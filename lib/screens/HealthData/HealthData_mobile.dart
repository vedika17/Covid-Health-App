import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/modals/HealthDataEntry.dart';

class HealthDataMobile extends StatefulWidget {
  final String phone;
  HealthDataMobile(this.phone);
  @override
  _HealthDataMobileState createState() => _HealthDataMobileState();
}

class _HealthDataMobileState extends State<HealthDataMobile> {
  final GlobalKey<FormState> _healthDataFromKey = GlobalKey<FormState>();

  String _oxygenLevel,
      _bodyTemp,
      _pulseRate,
      _other,
      _cough = "No",
      _cold = "No",
      _taste = "No",
      _smell = "No";

  Widget OxygenLevel(String hintText) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
//        suffixIcon: Icon(Icons.),
        labelText: (hintText),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return '$hintText is Required';
        }
//            else if (flagForWrong == 1) {
//              return 'Invalid User ID';
//            }
        return null;
      },
      onSaved: (value) {
        _oxygenLevel = value;
      },
    );
  }

  Widget PulseRate(String hintText) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
//        prefixIcon: Icon(Icons.perm_identity),
        labelText: (hintText),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return '$hintText is Required';
        }
//            else if (flagForWrong == 1) {
//              return 'Invalid User ID';
//            }
        return null;
      },
      onSaved: (value) {
        _pulseRate = value;
      },
    );
  }

  Widget BodyTemperature(String hintText) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
//        prefixIcon: Icon(Icons.),
        labelText: (hintText),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return '$hintText is Required';
        }
//            else if (flagForWrong == 1) {
//              return 'Invalid User ID';
//            }
        return null;
      },
      onSaved: (value) {
        _bodyTemp = value;
      },
    );
  }

  Widget Other(String hintText) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
//        prefixIcon: Icon(Icons.perm_identity),
        labelText: (hintText),
      ),
      validator: (String value) {
        return null;
      },
      onSaved: (value) {
        _other = value;
      },
    );
  }

  List<String> _status = ["Yes", "No"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding:
              EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
          child: Form(
            //initialization of login-page form key
            key: _healthDataFromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Health Data Entry",
                  style: new TextStyle(fontSize: 30.0),
                ),
                SizedBox(height: 30.0),
                //Body temperature
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 15,
                      color: primaryColor,
                      child: Center(
                          child: Text("Body Temperature",
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                    ),
                    Container(
                      child: Icon(Icons.arrow_forward,
                          size: MediaQuery.of(context).size.width / 10),
                    ),
                    Expanded(child: BodyTemperature("Body Temperature")),
                  ],
                ),
                SizedBox(height: 10.0),
                // Oxygen Level
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 15,
                      color: primaryColor,
                      child: Center(
                          child: Text("Oxygen Level",
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                    ),
                    Container(
                      child: Icon(Icons.arrow_forward,
                          size: MediaQuery.of(context).size.width / 10),
                    ),
                    Expanded(child: OxygenLevel("Oxygen Level")),
                  ],
                ),
                SizedBox(height: 10.0),
                //Pulse Rate
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 15,
                      color: primaryColor,
                      child: Center(
                          child: Text("Pulse Rate",
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                    ),
                    Container(
                      child: Icon(Icons.arrow_forward,
                          size: MediaQuery.of(context).size.width / 10),
                    ),
                    Expanded(child: PulseRate("Pulse Rate")),
                  ],
                ),
                SizedBox(height: 10.0),
                //Cough
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 15,
                      color: primaryColor,
                      child: Center(
                          child: Text("Cough",
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                    ),
                    Container(
                      child: Icon(Icons.arrow_forward,
                          size: MediaQuery.of(context).size.width / 10),
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
                SizedBox(height: 10.0),
                //Cold
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 15,
                      color: primaryColor,
                      child: Center(
                          child: Text("Cold",
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                    ),
                    Container(
                      child: Icon(Icons.arrow_forward,
                          size: MediaQuery.of(context).size.width / 10),
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
                SizedBox(height: 10.0),
                //Loss of Taste
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 15,
                      color: primaryColor,
                      child: Center(
                          child: Text("Loss of Taste",
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                    ),
                    Container(
                      child: Icon(Icons.arrow_forward,
                          size: MediaQuery.of(context).size.width / 10),
                    ),
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
                SizedBox(height: 10.0),
                //Loss of Smell
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 15,
                      color: primaryColor,
                      child: Center(
                          child: Text("Loss of Smell",
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                    ),
                    Container(
                      child: Icon(Icons.arrow_forward,
                          size: MediaQuery.of(context).size.width / 10),
                    ),
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
                SizedBox(height: 10.0),
                //Other Symptoms
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 15,
                      color: primaryColor,
                      child: Center(
                          child: Text("Other Symptoms",
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                    ),
                    Container(
                      child: Icon(Icons.arrow_forward,
                          size: MediaQuery.of(context).size.width / 10),
                    ),
                    Expanded(child: Other("Other Symptoms")),
                  ],
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                    //Sub,it button
                    child: new Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.width / 2,
//                  width: MediaQuery.of(context).size.height / 2,
                        decoration: new BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text("Submit",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white))),
                    onTap: () {
                      //validate contents of textField
                      if (!_healthDataFromKey.currentState.validate()) {
                        //if empty textField return
                        return;
                      }
                      // if not empty save in variables
                      _healthDataFromKey.currentState.save();
                      HealthDataEntry h = HealthDataEntry();
                      h.cold = _cold;
                      h.cough = _cough;
                      h.temprature = _bodyTemp;
                      h.lossofSmell = _smell;
                      h.lossofTaste = _taste;
                      h.other = _other;
                      h.oxy = _oxygenLevel;
                      h.pulse = _pulseRate;
                      DB().addHealthData(widget.phone, h);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
