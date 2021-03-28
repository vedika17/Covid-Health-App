import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covid_health_app/screens/DoctorHome/DoctorHome_mobile.dart';
import 'package:covid_health_app/screens/PatientHome/PatientHome_Mobile.dart';
import 'package:covid_health_app/screens/PhoneAuth/PhoneAuth_mobile.dart';
import 'firestore/db.dart';
import 'googleAuth/googleSignIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menon Health Tech Pvt Ltd.',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'halvetic'),
      ),
      debugShowCheckedModeBanner: false,
      home: Wrapper(), // LoginWithGmail(),  //Wrapper(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  Splash createState() => Splash();
}

//State class for Splash Screen
class Splash extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Logo
    var image = Image.asset("Images/logo.png", scale: 0.5);
    //<- Creates a widget that displays an image.
    //return with white background and logo
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: new Center(
              child: AspectRatio(
            aspectRatio: 3 / 2,
            child: image,
          )),
        ), //<- place where the image appears
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  //final User _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final User _user = FirebaseAuth.instance.currentUser;
    print("Current User");
    print(_user);
    if (_user != null) {
      String phone = _user.email;
      print("main dart");
      print(phone);
      return FutureBuilder(
          future: DB().isWho(phone),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null)
              return SplashScreen();
            else if (snapshot.data == "Doctor")
              return DoctorHome(phone);
            else if (snapshot.data == "Patient")
              return PatientHome(phone);
            else
              return PhoneAuthMobile(
                  phone); // PhoneAuthMobile(); // RegisterAs(phone);
          });
    } else {
      print("User null");
      return GoogleSign();
    }
  }
}

class SplashTime extends StatefulWidget {
  @override
  _SplashTimeState createState() => _SplashTimeState();
}

class _SplashTimeState extends State<SplashTime> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return GoogleSign(); //TutorialCarousel();
            })));
  }
}
