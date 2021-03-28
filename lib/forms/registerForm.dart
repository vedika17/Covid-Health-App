import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/forms/registerDoctor.dart';
import 'package:covid_health_app/forms/registerPatient.dart';

class RegisterForm extends StatefulWidget {
  final String email, _userType, phone;

  RegisterForm(this.email, this.phone, this._userType);

  @override
  _RegisterFormState createState() =>
      _RegisterFormState(email, phone, _userType);
}

class _RegisterFormState extends State<RegisterForm> {
  Widget form;
  String email;
  String phone;
  String _userType;

  _RegisterFormState(String email, String phone, String _userType) {
    this.email = email;
    this.phone = phone;
    this._userType = _userType;
  }

  Widget whichForm() {
    if (_userType == "User Form") {
      setState(() {
        form = RegisterPatient(email, phone);
      });
    } else {
      setState(() {
        form = RegisterDoctor(email, phone);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    whichForm();
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                _userType,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    decoration: TextDecoration.underline),
              ),
              form,
            ],
          ),
        ));
  }
}
