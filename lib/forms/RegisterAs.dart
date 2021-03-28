import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/forms/registerForm.dart';

class RegisterAs extends StatefulWidget {
  final String email;
  final String phone;

  RegisterAs(this.email, this.phone);

  @override
  _RegisterAsState createState() => _RegisterAsState(email, phone);
}

class _RegisterAsState extends State<RegisterAs> {
  String email;
  String phone;

  _RegisterAsState(String email, String phone) {
    this.email = email;
    this.phone = phone;
  }

  String _userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menon Health Tech",
          style: TextStyle(color: primaryColor),
        ),
        iconTheme: IconThemeData(color: primaryColor),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
                child: Image(
                    image: AssetImage('Images/appbar.png'),
                    height: 50,
                    width: 50)),
          ),
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "Register as:",
          style: TextStyle(
              fontSize: 50, color: primaryColor, fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 140,
              width: 140,
              child: RaisedButton(
                color: Colors.white,
                textColor: primaryColor,
                hoverColor: Colors.white,
                shape: Border.all(color: primaryColor, width: 3),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Icon(FontAwesomeIcons.userAlt,
                          size: 50, color: primaryColor),
                      SizedBox(height: 20),
                      Text(
                        "USER",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  _userType = "User Form";
                  print("User pressed");
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              RegisterForm(email, phone, _userType)));
                },
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Container(
              height: 140,
              width: 140,
              child: RaisedButton(
                color: Colors.white,
                textColor: primaryColor,
                hoverColor: Colors.white,
                shape: Border.all(color: primaryColor, width: 3),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Icon(FontAwesomeIcons.userMd,
                          size: 50, color: primaryColor),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "DOCTOR",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                onPressed: () {
                  _userType = "Doctor Form";
                  print("Doctor pressed");
                  // DB().deleteUser();

                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              RegisterForm(email, phone, _userType)));
                },
              ),
            ),
          ],
        )
      ]),
    );
  }
}
