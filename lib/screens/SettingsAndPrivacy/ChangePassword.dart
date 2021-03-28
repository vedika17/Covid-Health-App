import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/modals/Patient.dart';
import 'package:covid_health_app/screens/SettingsAndPrivacy/PatientPage.dart';

class ChangePassword extends StatefulWidget {
  final String pE;
  final Patient p;

  ChangePassword(this.pE, this.p);
  @override
  _ChangePasswordState createState() => _ChangePasswordState(p, pE);
}

class _ChangePasswordState extends State<ChangePassword> {
  Patient p;
  String pE;
  String newPass, cNewPass, pass;
  bool _pass = true;
  bool _pass1 = true;
  bool _pass2 = true;
  IconData eye = Icons.visibility_off;
  IconData eye1 = Icons.visibility_off;
  IconData eye2 = Icons.visibility_off;
  _ChangePasswordState(this.p, this.pE);

  Widget _buildPass() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        maxLength: 10,
        obscureText: _pass,
        decoration: InputDecoration(
            hintText: "Current Password",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            prefixIcon: Icon(Icons.linear_scale),
            labelText: ("Current Password"),
            suffixIcon: IconButton(
                icon: Icon(eye),
                onPressed: () {
                  setState(() {
                    _pass = !_pass;
                    if (_pass) {
                      eye = Icons.visibility_off;
                    } else {
                      eye = Icons.visibility;
                    }
                  });
                })),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          if (value != p.pass) {
            return "Password is incorrect";
          }

          return null;
        },
        onSaved: (value) {
          pass = value;
        },
      ),
    );
  }

  Widget _buildNewPass() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        maxLength: 10,
        obscureText: _pass,
        decoration: InputDecoration(
            hintText: "New Password",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            prefixIcon: Icon(Icons.linear_scale),
            labelText: ("New Password"),
            suffixIcon: IconButton(
                icon: Icon(eye1),
                onPressed: () {
                  setState(() {
                    _pass1 = !_pass1;
                    if (_pass1) {
                      eye1 = Icons.visibility_off;
                    } else {
                      eye1 = Icons.visibility;
                    }
                  });
                })),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          if (value == p.pass) {
            return "New password is same as current password";
          }

          return null;
        },
        onSaved: (value) {
          newPass = value;
        },
      ),
    );
  }

  Widget _buildCNewPass() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        maxLength: 10,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Confirm New Password",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.linear_scale),
          suffixIcon: IconButton(
              icon: Icon(eye2),
              onPressed: () {
                setState(() {
                  _pass2 = !_pass2;
                  if (_pass2) {
                    eye2 = Icons.visibility_off;
                  } else {
                    eye2 = Icons.visibility;
                  }
                });
              }),
          labelText: ("Confirm New Password"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          if (value.length < 6) {
            return "Too Short";
          }

          return null;
        },
        onSaved: (value) {
          cNewPass = value;
        },
      ),
    );
  }

  final GlobalKey<FormState> _pFormKey = GlobalKey<FormState>();
  @override
  Widget build(context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Theme(
            data: ThemeData(iconTheme: IconThemeData(color: primaryColor)),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
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
        body: Container(
          margin: EdgeInsets.all(24),
          child: Form(
              key: _pFormKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Change Password",
                      style: TextStyle(color: primaryColor, fontSize: 25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildPass(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildNewPass(),
                    SizedBox(height: 10),
                    _buildCNewPass(),
                    SizedBox(height: 10),
                    RaisedButton(
                        color: primaryColor,
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Save Changes",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onPressed: () async {
                          if (!_pFormKey.currentState.validate()) return;

                          _pFormKey.currentState.save();
                          //var stat = await DB().notification(phone);
                          if (newPass != cNewPass) {
                            Widget okButton = FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                            AlertDialog alert = AlertDialog(
                              title: Text("Error"),
                              content: Text("Password mismatched"),
                              actions: [
                                okButton,
                              ],
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );

                            print("Password not same");
                            return;
                          }
                          DB().changepassword(pE, newPass);
                          Widget okButton = FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PatientProfilePage(pE)));
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: Text("Password Changed"),
                            actions: [
                              okButton,
                            ],
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
