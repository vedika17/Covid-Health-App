import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/modals/Appointment.dart';
import '../../constants/app_colors.dart';

class ScheduleForm extends StatefulWidget {
  final String dN;
  final String pN;

  ScheduleForm(this.pN, this.dN);
  @override
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  final GlobalKey<FormState> _scheduleFromKey = GlobalKey<FormState>();

  DateTime selectedDate;
  bool checkBOD = true;
  String _reason, _package, _timeAvailable, _timeNotAvailable, _appointmentType;

  Future pickDate() async {
    print("Pick Date");
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2021),
    );
    // lastDate: DateTime(DateTime.now().day + 7));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget _buildDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Appointment Date",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: pickDate,
          color: primaryColor,
          iconSize: 25,
        ),
        () {
          if (selectedDate == null) {
            checkBOD = false;
            return Text(
              "Click on Icon",
              style: TextStyle(fontSize: 18, color: primaryColor),
            );
          } else if (selectedDate.isBefore(DateTime.now())) {
            checkBOD = false;
            return Text("Please enter valid date",
                style: TextStyle(color: Colors.red));
          } else {
            checkBOD = true;
            return Text(
              selectedDate.day.toString() +
                  "-" +
                  selectedDate.month.toString() +
                  "-" +
                  selectedDate.year.toString(),
            );
          }
        }(),
      ],
    );
  }

  Widget _buildPackageOption() {
    return Material(
      child: Theme(
        data: ThemeData(primaryColor: primaryColor),
        child: DropdownButtonFormField(
            decoration: InputDecoration(
              hintText: "Package Option",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              prefixIcon: Icon(FontAwesomeIcons.envelopeOpen),
              labelText: ("Package Option"),
            ),
            items: [
              "First time",
              "Follow up",
            ]
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (String selected) {
              setState(() {
                _package = selected;
              });
            }),
      ),
    );
  }

  Widget _buildAppointmnetType() {
    return Material(
      child: Theme(
        data: ThemeData(primaryColor: primaryColor),
        child: DropdownButtonFormField(
            decoration: InputDecoration(
              hintText: "Appointment Type",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              prefixIcon: Icon(FontAwesomeIcons.envelopeOpen),
              labelText: ("Appointment Option"),
            ),
            items: [
              "Virtual",
              "In Person",
            ]
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (String selected) {
              setState(() {
                _appointmentType = selected;
              });
            }),
      ),
    );
  }

  Widget _buildAvailableTime() {
    return Material(
      child: Theme(
        data: ThemeData(primaryColor: primaryColor),
        child: DropdownButtonFormField(
            decoration: InputDecoration(
              hintText: "When are you available for the appointment?",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              prefixIcon: Icon(FontAwesomeIcons.envelopeOpen),
              labelText: ("Available Time"),
            ),
            items: [
              "Morning",
              "Afternoon",
              "Evening",
            ]
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (String selected) {
              setState(() {
                _timeAvailable = selected;
              });
            }),
      ),
    );
  }

  Widget _buildUnavilableTime() {
    return Material(
      child: Theme(
        data: ThemeData(primaryColor: primaryColor),
        child: DropdownButtonFormField(
            decoration: InputDecoration(
              hintText: "Any time you're not available?",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              prefixIcon: Icon(FontAwesomeIcons.envelopeOpen),
              labelText: ("Unavailable Time"),
            ),
            items: ["Morning", "Afternoon", "Evening", "None"]
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (String selected) {
              setState(() {
                _timeNotAvailable = selected;
              });
            }),
      ),
    );
  }

  Widget _buildReason() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        autofocus: false,
        decoration: InputDecoration(
          hintText: "Reason for you want to meet",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.list_alt),
          labelText: ("Reason for you want to meet"),
        ),
        validator: (String value) {
          return null;
        },
        onSaved: (value) {
          _reason = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(
                top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
            child: Form(
              key: _scheduleFromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Schedule Appointment",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: primaryColor)),
                  SizedBox(height: 30.0),
                  //Show Doctor Details
                  SizedBox(
                    height: 10,
                  ),
                  _buildDate(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildAvailableTime(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildUnavilableTime(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildPackageOption(),
                  SizedBox(height: 10),
                  _buildAppointmnetType(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildReason(),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: RaisedButton(
                        textColor: Colors.white,
                        color: primaryColor,
                        child: Text("Submit"),
                        onPressed: () {
                          if (!_scheduleFromKey.currentState.validate()) {
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
                          _scheduleFromKey.currentState.save();
                          Appointment a = Appointment();
                          a.aDate = selectedDate;
                          a.doctorNumber = widget.dN;
                          a.package = _package;
                          a.reason = _reason;
                          a.patientNumber = widget.pN;
                          a.availableTime = _timeAvailable;
                          a.unavailableTime = _timeNotAvailable;
                          a.appointmentType = _appointmentType;
                          String input = "Appointment request for " +
                              a.aDate.toString().substring(0, 10) +
                              " is requested";
                          DB().sendNotification(widget.dN, input, widget.pN);
                          DB().addAppointmentPatient(widget.dN, widget.pN, a);
                          AlertDialog alert = AlertDialog(
                            title: Text("Appointment Request Sent"),
                            content: Text(
                                "Doctor will fix a time for your appoinmnet soon"),
                            actions: [
                              FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                },
                              )
                            ],
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
