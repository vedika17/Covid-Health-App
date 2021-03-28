import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/screens/DoctorHome/DoctorHome_mobile.dart';
import 'package:covid_health_app/screens/PatientHome/PatientHome_Mobile.dart';
import 'package:covid_health_app/screens/PhoneAuth/PhoneAuth_mobile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class GoogleSign extends StatefulWidget {
  @override
  _GoogleSignState createState() => _GoogleSignState();
}

class _GoogleSignState extends State<GoogleSign> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      FirebaseMessaging firebaseMessaging = FirebaseMessaging();
      String fcmToken = await firebaseMessaging.getToken();

      DB().updateFCMToken(user.email.toString(), fcmToken);
      print('signInWithGoogle succeeded: $user');

      return '$user';
    }

    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Signed Out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Images/logo2.png")))),
              //FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          // return Wrapper();
          print("result in google sign-in : " + result);
          if (result != null) {
            final User checkUser = FirebaseAuth.instance.currentUser;
            String userEmail = checkUser.email;
            print("then : " + userEmail);
            // return FutureBuilder(
            //     future: DB().isWho(userEmail),
            //     builder: (BuildContext context, AsyncSnapshot snapshot) {
            //       if (snapshot.data == null)
            //         return SplashScreen();
            //       else if (snapshot.data == "Doctor")
            //         return DoctorHome(userEmail);
            //       else if (snapshot.data == "Patient")
            //         return PatientHome(userEmail);
            //       else
            //         return PhoneAuthMobile();
            //     });
            DB().isWho(userEmail).then((who) {
              if (who == "Doctor") {
                print("recognized doctor");
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) {
                  return DoctorHome(userEmail);
                }));
              } else if (who == "Patient") {
                print("recognized patient");
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) {
                  return PatientHome(userEmail);
                }));
              } else {
                print("recognized nothing");
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) {
                  return PhoneAuthMobile(userEmail);
                }));
              }
            });
          } else {
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return GoogleSign();
            }));
          }
          print("Getting out of function without going to any home");
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("Images/google.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
