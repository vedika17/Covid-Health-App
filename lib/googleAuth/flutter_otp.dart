//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:healthmenon/constants/app_colors.dart';
// import 'package:healthmenon/widgets/CustomAlert.dart';
// import 'package:healthmenon/widgets/Loading.dart';
//
// import 'flutterOtp.dart';
//
// class flutterOtp extends StatefulWidget {
//   @override
//   _flutterOtpState createState() => _flutterOtpState();
// }
//
// class _flutterOtpState extends State<flutterOtp> {
//
//   Color btn_color = Colors.blue;
//   Widget btn_child = Text(
//     "Send OTP",
//     style: TextStyle(
//       fontSize: 20,
//       color: Colors.white,
//     ),
//   );
//   Widget btn_pressed = Text(
//     "Send OTP",
//     style: TextStyle(
//       fontSize: 20,
//       color: Colors.white,
//     ),
//   );
//
//   final PageController contr = PageController();
//
//   final TextEditingController _mobController = TextEditingController();
//
//   final TextEditingController _codeController = TextEditingController();
//
//   final _firebaseAuth = FirebaseAuth.instance;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       body: Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(50.0),
//         child: Column(
//           children: <Widget>[
//             Text(
//               "Enter Mobile Number to Continue",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//               textAlign: TextAlign.left,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text("You will receive OTP on the below entered Mobile Number"),
//             SizedBox(
//               height: 20,
//             ),
//             TextField(
//               cursorColor: Colors.white,
//               controller: _mobController,
//               keyboardType: TextInputType.number,
//               autofocus: false,
//               maxLength: 10,
//               maxLines: 1,
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.white, fontSize: 34),
//               smartDashesType: SmartDashesType.enabled,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             RaisedButton(
//               padding: EdgeInsets.all(15),
//               color: btn_color,
//               onPressed: () async {
//                 setState(() {
//                   btn_child = btn_pressed;
//                   btn_color = Colors.grey;
//                 });
//                 String phone = _mobController.text.trim();
//                 if (phone.length != 10) {
//                   ShowAlert("Incorrect", "Please Check entered Mobile Number",
//                       context);
//                   setState(() {
//                     btn_color = Colors.blue;
//                   });
//                 }
//                 var rt = await FlutterOtp().sendOtp(phone); //await authenticatePhone(phone);
//                 if (rt == null) {
//                   btn_child = Loading();
//                 }
//               },
//               child: btn_child,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
