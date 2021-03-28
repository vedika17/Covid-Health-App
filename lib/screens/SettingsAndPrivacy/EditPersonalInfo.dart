import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/modals/Patient.dart';

class EditPersonalInfo extends StatefulWidget {
  final String pE;
  final Patient p;

  EditPersonalInfo(this.pE, this.p);
  @override
  _EditPersonalInfoState createState() => _EditPersonalInfoState(pE, p);
}

class _EditPersonalInfoState extends State<EditPersonalInfo> {
  Patient p;
  String pE;
  _EditPersonalInfoState(this.pE, this.p);
  String covid;
  Patient p1 = new Patient();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Widget _buildCovid() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            hintText: p.covidStatus,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            prefixIcon: Icon(Icons.coronavirus),
            labelText: ("Covid Status"),
          ),
          items: [
            "Symptoms for COVID-19",
            "Tested COVID-19 Positive",
            "Registering for precaution"
          ]
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (String selected) {
            setState(() {
              p1.covidStatus = selected;
            });
          }),
    );
  }

  Widget _buildAadharNo() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: p.aadharNo,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.perm_identity),
          labelText: ("Aadhar Number"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            p1.aadharNo = p.aadharNo;
          }
          // RegExp re = new RegExp(r'/^[A-Za-z]+$/');
          // if (!re.hasMatch(value)) return "Please Enter Alphabets";

          return null;
        },
        onSaved: (value) {
          p1.aadharNo = value;
        },
      ),
    );
  }

  Widget _buildHeight() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: p.height,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.arrow_circle_up),
          labelText: ("Height"),
        ),
        validator: (value) {
          // ignore: unrelated_type_equality_checks
          RegExp re = new RegExp(r'^\d*\.?\d*$');
          if (!re.hasMatch(value)) return "Please Enter Numerics";
          if (value.isEmpty) {
            p1.height = p.height;
          }
        },
        onSaved: (value) {
          p1.height = value;
        },
      ),
    );
  }

  Widget _buildWeight() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: p.weight,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.linear_scale),
          labelText: ("Weight"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          RegExp re = new RegExp(r'^\d*\.?\d*$');
          if (!re.hasMatch(value)) return "Please Enter Numerics";
          if (value.isEmpty) {
            p1.weight = p.weight;
          }
        },
        onSaved: (value) {
          p1.weight = value;
        },
      ),
    );
  }

  final GlobalKey<FormState> _pFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                      "Edit Personal Information",
                      style: TextStyle(color: primaryColor, fontSize: 25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildAadharNo(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildHeight(),
                    SizedBox(height: 10),
                    _buildWeight(),
                    SizedBox(height: 10),
                    _buildCovid(),
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
                          if (p1.aadharNo == "") {
                            p1.aadharNo = p.aadharNo;
                            print(p1.aadharNo);
                          }
                          if (p1.height == "") {
                            p1.height = p.height;
                            print(p1.height);
                          }
                          if (p1.weight == "") {
                            p1.weight = p.weight;
                            print(p.weight);
                          }
                          if (p1.covidStatus == null) {
                            p1.covidStatus = p.covidStatus;
                            print(p1.covidStatus);
                          }
                          DB().updatePersonalInfo(pE, p1);
                        }),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
