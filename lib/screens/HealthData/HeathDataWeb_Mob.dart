import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/modals/HealthDataEntry.dart';
import 'package:covid_health_app/modals/OtherReports.dart';
import 'package:covid_health_app/screens/PatientHome/PatientHomePage.dart';
import 'package:covid_health_app/screens/otherReports/patientOtherReports.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthDataMobileWeb extends StatefulWidget {
  final String phone;
  HealthDataMobileWeb(this.phone);
  @override
  _HealthDataMobileWebState createState() => _HealthDataMobileWebState();
}

Widget _buildInstructions(BuildContext context) {
  return SingleChildScrollView(
    child: new AlertDialog(
      title: const Text(
        "Instructions",
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      ),
      content: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Image(
              image: AssetImage('Images/Instructions.jpg'),
            ),
          )
        ],
      ),
      actions: <Widget>[
        Center(
          child: new RaisedButton(
            color: primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Colors.white,
            child: const Text("Close"),
          ),
        )
      ],
    ),
  );
}

class _HealthDataMobileWebState extends State<HealthDataMobileWeb> {
  final GlobalKey<FormState> _healthDataFromKey = GlobalKey<FormState>();

  String _oxygenLevel,
      _bodyTemp,
      _pulseRate,
      _other,
      _cough = "none",
      _cold = "none",
      _taste = "none",
      _smell = "none",
      coughType;

  Widget _buildOxygenLevel() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        autofocus: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Oxygen (SpO2%)",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          //suffixIcon: Icon(Icons.),
          labelText: ("Oxygen (SpO2%)"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return "This is Required";
          }
          RegExp re = new RegExp(r'^\d*\.?\d*$');
          if (!re.hasMatch(value)) return "Please Enter Numerics";
//            else if (flagForWrong == 1) {
//              return 'Invalid User ID';
//            }
          return null;
        },
        onSaved: (value) {
          _oxygenLevel = value;
        },
      ),
    );
  }

  Widget _buildPulseRate() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        autofocus: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Pulse Rate BPM",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
//        prefixIcon: Icon(Icons.perm_identity),
          labelText: ("Pulse Rate in BPM"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return "This is Required";
          }
          RegExp re = new RegExp(r'^\d*\.?\d*$');
          if (!re.hasMatch(value)) return "Please Enter Numerics";
//            else if (flagForWrong == 1) {
//              return 'Invalid User ID';
//            }
          return null;
        },
        onSaved: (value) {
          _pulseRate = value;
        },
      ),
    );
  }

  Widget _buildBodyTemperature() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        autofocus: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Temperature",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
//        prefixIcon: Icon(Icons.),
          labelText: ("Temperature °F"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return "This is Required";
          }
          RegExp re = new RegExp(r'^\d*\.?\d*$');
          if (!re.hasMatch(value)) return "Please Enter Numerics";
//            else if (flagForWrong == 1) {
//              return 'Invalid User ID';
//            }
          return null;
        },
        onSaved: (value) {
          _bodyTemp = value;
        },
      ),
    );
  }

  Widget _buildOther() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        autofocus: false,
        decoration: InputDecoration(
          hintText: "Other Symptoms",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
//        prefixIcon: Icon(Icons.perm_identity),
          labelText: ("Any Other Symptoms"),
        ),
        validator: (String value) {
          return null;
        },
        onSaved: (value) {
          _other = value;
        },
      ),
    );
  }

  Widget _buildCoughType() {
    return DropdownButtonFormField(
        focusColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Cough Type",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          prefixIcon: Icon(Icons.people),
          labelText: ("Cough Type"),
        ),
        items: ["Dry", "Wet"]
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (String selected) {
          setState(() {
            coughType = selected;
            print(coughType);
          });
        });
  }

  List<String> _status = ["Yes", "No"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          "Health Data Entry",
          style: TextStyle(color: primaryColor),
          textAlign: TextAlign.center,
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
              key: _healthDataFromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height / 10,
                    child: RaisedButton(
                      padding: EdgeInsets.all(10),
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    AddOtherReports(widget.phone)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add other reports",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.add_circle_outline_sharp,
                              color: Colors.white, size: 22),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: InkWell(
                          child: Text(
                            "Tap here for Instructions",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: primaryColor,
                                fontSize: 20),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildInstructions(context),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Add Health Data",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: primaryColor)),
                  SizedBox(
                    height: 10,
                  ),
                  _buildBodyTemperature(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildOxygenLevel(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildPulseRate(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Do you have Cough?",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: _cough,
                        onChanged: (value) => setState(() {
                          _cough = value;
                        }),
                        items: _status,
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),
                    ],
                  ),
                  () {
                    if (_cough == "Yes") {
                      return _buildCoughType();
                    } else {
                      return SizedBox(
                        height: 0,
                      );
                    }
                  }(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Do you have Cold?",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: _cold,
                        onChanged: (value) => setState(() {
                          _cold = value;
                        }),
                        items: _status,
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Loss of Taste?",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: _taste,
                        onChanged: (value) => setState(() {
                          _taste = value;
                        }),
                        items: _status,
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Loss of Smell?",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: _smell,
                        onChanged: (value) => setState(() {
                          _smell = value;
                        }),
                        items: _status,
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildOther(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: RaisedButton(
                        textColor: Colors.white,
                        color: primaryColor,
                        child: Text("Submit"),
                        onPressed: () {
                          //validate contents of textField
                          if (_cold == "none" ||
                              _cough == "none" ||
                              _taste == "none" ||
                              _smell == "none") {
                            Widget okButton = FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                            AlertDialog alert = AlertDialog(
                              title: Text("Error"),
                              content: Text("Fill all Fields"),
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

                            return;
                          }
                          if (!_healthDataFromKey.currentState.validate()) {
                            //if empty textField return
                            return null;
                          }

                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          // if not empty save in variables
                          _healthDataFromKey.currentState.save();
                          HealthDataEntry h = HealthDataEntry();
                          h.cold = _cold;
                          h.cough = _cough;
                          h.temprature = _bodyTemp;
                          h.lossofSmell = _smell;
                          h.coughType = coughType;
                          h.lossofTaste = _taste;
                          h.other = _other;
                          h.oxy = _oxygenLevel;
                          h.pulse = _pulseRate;
                          DB().addHealthData(widget.phone, h);
                          Navigator.of(context).pop();
                          Widget okButton = FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              setState(() {
                                _cold = _cough = _taste = _smell = "None";
                              });
                              Navigator.of(context).pop();
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: Text("Done"),
                            content: Text("Data Added"),
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
                          _healthDataFromKey.currentState.reset();
                        }),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Consult your doctor immediately if any of the following occur",
                            style: TextStyle(
                                fontSize: 20,
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "- Oxygen level is below 94%",
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          ),
                          Text(
                            "- Resting pulse rate is consistantly above 100 BPM or below 60 BPM for more 2 days",
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          ),
                          Text(
                            "- Body temperature is consistantly above 101 deg F for more than 2 days",
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
