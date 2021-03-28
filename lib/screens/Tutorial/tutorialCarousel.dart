//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:healthmenon/constants/app_colors.dart';
// import 'package:healthmenon/firestore/db.dart';
// import 'package:healthmenon/forms/RegisterAs.dart';
// import 'package:healthmenon/screens/PhoneAuth/PhoneAuth_mobile.dart';
// import 'package:healthmenon/widgets/CustomAlert.dart';
// import 'package:healthmenon/widgets/CustomLoading.dart';
//
// class TutorialCarousel extends StatefulWidget {
//   @override
//   _TutorialCarouselState createState() => _TutorialCarouselState();
// }
//
// class _TutorialCarouselState extends State<TutorialCarousel> {
//   final PageController contr = PageController();
//   final TextEditingController _mobController = TextEditingController();
//   final TextEditingController _codeController = TextEditingController();
//   var _firebaseAuth = FirebaseAuth.instance;
//
//
//   Future authenticatePhone(String phone) async {
//     phone = "+91" + phone;
//     bool stat = true;
//     var result = await DB().isWho(phone);
//     if (result == null) {
//       ShowLoading(context).showLoading();
//     } else {
//       print(result);
//       if (result == "Doctor") {
//         /*
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => PatientList(phone)));*/
//       } else if (result == "Patient") {
//         /*
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => PatientHome(phone,stat)));*/
//       } else {
//         if (kIsWeb) {
//           try {
//             _firebaseAuth.signInWithPhoneNumber(
//                 phone,
//                 RecaptchaVerifier(
//                   container: "reCaptcha",
//                 ));
//           } catch (e) {
//             print(e);
//             return e.message;
//           }
//         } else {
//           try {
//             _firebaseAuth.verifyPhoneNumber(
//                 phoneNumber: phone,
//                 verificationCompleted: (PhoneAuthCredential credential) async {
//                   Navigator.of(context).pop();
//                   print("Auto Verified");
//                   var result =
//                   await _firebaseAuth.signInWithCredential(credential);
//                   User user = result.user;
//                   if (user != null) {
//                     Navigator.of(context).pushReplacement(new MaterialPageRoute(
//                         builder: (context) => RegisterAs(user.phoneNumber)));
//                   }
//                 },
//                 verificationFailed: (FirebaseAuthException fe) {
//                   print(fe);
//                   print(fe.message);
//                   return fe.message;
//                 },
//                 codeSent: (String verificationID, int resendToken) async {
//                   showDialog(
//                       context: context,
//                       barrierDismissible: false,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: Text("Enter OTP"),
//                           content: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               TextField(
//                                 controller: _codeController,
//                               ),
//                             ],
//                           ),
//                           actions: <Widget>[
//                             FlatButton(
//                               child: Text("Confirm"),
//                               textColor: Colors.white,
//                               color: Colors.blue,
//                               onPressed: () async {
//                                 CircularProgressIndicator();
//                                 final code = _codeController.text.trim();
//                                 AuthCredential credential =
//                                 PhoneAuthProvider.credential(
//                                     verificationId: verificationID,
//                                     smsCode: code);
//
//                                 UserCredential result = await _firebaseAuth
//                                     .signInWithCredential(credential);
//                                 if (result == null) {
//                                   ShowLoading(context).showLoading();
//                                 }
//                                 User user = result.user;
//
//                                 if (user != null) {
//                                   /*
//                                   Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               RegisterAs(user.phoneNumber)));
//
//                                    */
//                                 } else {
//                                   ShowAlert("Login error", "Login Failed",
//                                       context)
//                                       .showAlertDialog();
//                                   Navigator.pop(context);
//                                 }
//                               },
//                             )
//                           ],
//                         );
//                       });
//                 },
//                 codeAutoRetrievalTimeout: (String s) {
//                   print("AutoRetrival Time out!");
//                 });
//           } catch (e) {
//             print(e);
//             return e.message;
//           }
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var rt;
//     return Scaffold(
//         backgroundColor: primaryColor,
//         body: PageView(
//           scrollDirection: Axis.horizontal,
//           controller: contr,
//           children: [
//             Container(
//               child: Image.asset('Images/img1.png'),
//             ),
//             Container(
//               child: Image.asset('Images/img2.png'),
//             ),
//             Container(
//               child: Image.asset('Images/img3.png'),
//             ),
//             Container(
//                 alignment: Alignment.center,
//                 padding: EdgeInsets.all(50.0),
//                 child: RaisedButton(
//                     padding: EdgeInsets.all(20),
//                     color: Colors.blue,
//                     elevation: 5,
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => PhoneAuthMobile()));
//                     },
//                     child: Text(
//                       "Get Started!!!!",
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                     ))),
//           ],
//         ));
//   }
// }
