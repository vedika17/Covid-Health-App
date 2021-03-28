import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/forms/RegisterAs.dart';
import 'package:covid_health_app/widgets/CustomAlert.dart';
import 'package:covid_health_app/widgets/CustomLoading.dart';
import 'package:covid_health_app/widgets/Loading.dart';

class PhoneAuthMobile extends StatefulWidget {
  final String email;
  PhoneAuthMobile(this.email);
  @override
  _PhoneAuthMobileState createState() => _PhoneAuthMobileState();
}

class _PhoneAuthMobileState extends State<PhoneAuthMobile> {
  Color btn_color = Colors.blue;
  Widget btn_child = Text(
    "Send OTP",
    style: TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
  );
  Widget btn_pressed = Text(
    "Send OTP",
    style: TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
  );
  final PageController contr = PageController();

  final TextEditingController _mobController = TextEditingController();

  final TextEditingController _codeController = TextEditingController();

  final _firebaseAuth = FirebaseAuth.instance;

  Future authenticatePhone(String phone) async {
    phone = "+91" + phone;
    var result = await DB().isWho(phone);
    if (result == null) {
      ShowLoading(context).showLoading();
    } else {
      try {
        _firebaseAuth.verifyPhoneNumber(
            phoneNumber: phone,
            verificationCompleted: (PhoneAuthCredential credential) async {
              Navigator.of(context).pop();
              print("Auto Verified");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterAs(widget.email, phone)));
            },
            verificationFailed: (FirebaseAuthException fe) {
              print(fe);
              print(fe.message);
              return fe.message;
            },
            codeSent: (String verificationID, int resendToken) async {
              print("Code Send Gets Calls");
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Enter OTP"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: _codeController,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Confirm"),
                          textColor: Colors.white,
                          color: Colors.blue,
                          onPressed: () async {
                            var sms = _codeController.text.trim();

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegisterAs(widget.email, phone)));
                          },
                        )
                      ],
                    );
                  });
            },
            codeAutoRetrievalTimeout: (String s) {
              print("AutoRetrival Time out!");
            });
      } catch (e) {
        print(e);
        return e.message;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(50.0),
          child: Column(
            children: [
              Text(
                "Enter Mobile Number to Continue",
                style: TextStyle(fontSize: 20, color: primaryColor),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Text("You will receive OTP on the below entered Mobile Number"),
              SizedBox(
                height: 20,
              ),
              TextField(
                cursorColor: Colors.white,
                controller: _mobController,
                keyboardType: TextInputType.number,
                autofocus: false,
                maxLength: 10,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(color: primaryColor, fontSize: 34),
                smartDashesType: SmartDashesType.enabled,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 25,
              ),
              RaisedButton(
                padding: EdgeInsets.all(15),
                color: btn_color,
                onPressed: () async {
                  setState(() {
                    btn_child = btn_pressed;
                    btn_color = Colors.grey;
                  });
                  String phone = _mobController.text.trim();
                  if (phone.length != 10) {
                    ShowAlert("Incorrect", "Please Check entered Mobile Number",
                        context);
                    setState(() {
                      btn_color = Colors.blue;
                    });
                  }
                  var rt = await authenticatePhone(phone);
                  if (rt == null) {
                    btn_child = Loading();
                  }
                },
                child: btn_child,
              )
            ],
          )),
    );
  }
}
