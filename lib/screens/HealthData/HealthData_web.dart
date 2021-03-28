import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

class HealthDataWeb extends StatefulWidget {
  @override
  _HealthDataWebState createState() => _HealthDataWebState();
}

class _HealthDataWebState extends State<HealthDataWeb> {
  final GlobalKey<FormState> _healthDataFromKey = GlobalKey<FormState>();

  String _oxygenLevel,
      _bodyTemp,
      _pulseRate,
      _other,
      _cough = "No",
      _cold = "No",
      _taste = "No",
      _smell = "No",
      coughType;
  Widget _buildOxygenLevel() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Oxygen Level",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
//        suffixIcon: Icon(Icons.),
        labelText: ("Oxygen SpO2"),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return "This is Required";
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

  Widget _buildPulseRate() {
    return TextFormField(
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

  Widget _buildBodyTemperature() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Temprature",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
//        prefixIcon: Icon(Icons.),
        labelText: ("Temprature in Fahrenheit"),
      ),
      validator: (String value) {
        // ignore: unrelated_type_equality_checks
        if (value.isEmpty) {
          return "This is Required";
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

  Widget _buildOther() {
    return TextFormField(
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
    );
  }

  Widget _buildCoughType() {
    return DropdownButtonFormField(
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
    var w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(10),
      child: Form(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Add Health Data",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: w / 3,
                  child: _buildOxygenLevel(),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: w / 3,
                  child: _buildBodyTemperature(),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: w / 3,
                  child: _buildPulseRate(),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                    width: w / 3,
                    child: Row(
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
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: w / 3,
                    child: Row(
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
                    )),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: w / 3,
                  child: () {
                    if (_cough == "Yes") {
                      return _buildCoughType();
                    } else {
                      return SizedBox(
                        height: 0,
                      );
                    }
                  }(),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: w / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Loss of Taste?",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      SizedBox(
                        width: 10,
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
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: w / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Loss of Smell?",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      SizedBox(
                        width: 10,
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
