import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/modals/Appointment.dart';
import 'package:covid_health_app/widgets/Loading.dart';

import 'package:url_launcher/url_launcher.dart';

class AppointmentSpecific extends StatefulWidget {
  final String pE;
  final String dE;
  AppointmentSpecific(this.pE, this.dE);

  @override
  _AppointmentSpecificState createState() => _AppointmentSpecificState();
}

class _AppointmentSpecificState extends State<AppointmentSpecific> {
  final GlobalKey<FormState> _timeKey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _notesKey = new GlobalKey<FormState>();
  TimeOfDay timeSelected = TimeOfDay.now();
  TimeOfDay time = TimeOfDay.now();
  String _notes;

  Future pickTime() async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: timeSelected,
    );
    if (picked != null) {
      setState(() {
        timeSelected = picked;
        print("timeSelected");
      });
    }
  }

  Widget _buildTime(String aTime) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Choose Time for appointment",
            style: TextStyle(
              color: primaryColor,
              fontSize: 18.0,
            )),
        SizedBox(
          height: 2,
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.clock),
          onPressed: pickTime,
          color: primaryColor,
          iconSize: 50,
        ),
        SizedBox(
          height: 2,
        ),
        () {
          if (timeSelected != time) {
            return Text(
              "\n" +
                  timeSelected.hour.toString() +
                  ":" +
                  timeSelected.minute.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            );
          } else {
            return Text(
              "Click on icon",
              style: TextStyle(color: Colors.black, fontSize: 20),
            );
          }
        }(),
      ],
    );
  }

  Widget _buildNotes() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        autofocus: false,
        decoration: InputDecoration(
          hintText: "Notes",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.list_alt),
          labelText: ("Notes about Appointment"),
        ),
        validator: (String value) {
          return null;
        },
        onSaved: (value) {
          _notes = value;
        },
      ),
    );
  }

  Widget _listViewRequestedAppointments() {
    return FutureBuilder(
      future: DB().getRequetedAppointmentsSpecific(widget.dE, widget.pE),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Loading();
        } else if (snapshot.data.length == 0) {
          return Container(
            height: 50,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "You've no new Requested Appointments",
                  style: TextStyle(color: primaryColor, fontSize: 16),
                ),
              ),
            ),
          );
        } else {
          return Container(
            height: (snapshot.data.length) * 130.00,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int i) {
                return Divider(
                  color: Colors.transparent,
                );
              },
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: primaryColor, width: 2),
                  ),
                  child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      tileColor: Colors.white,
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("Images/doctor.png"),
                      ),
                      title: Text(
                        snapshot.data[index].patientName,
                        style: TextStyle(color: primaryColor, fontSize: 25),
                      ),
                      subtitle: Text(
                        "Date : " +
                            snapshot.data[index].aDateS.substring(0, 10) +
                            "\tReason : " +
                            snapshot.data[index].reason,
                        style: TextStyle(color: primaryColor, fontSize: 20),
                      ),
                      trailing: IconButton(
                        color: primaryColor,
                        icon: Icon(Icons.phone),
                        onPressed: () {
                          launch("tel:" + snapshot.data[index].patientNumber);
                        },
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  content: Stack(
                                overflow: Overflow.visible,
                                children: [
                                  Positioned(
                                    right: -15,
                                    top: -10,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: Colors.white,
                                        foregroundColor: primaryColor,
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Form(
                                      key: _timeKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 40, bottom: 40),
                                            child: Text(
                                              "Approve Patient",
                                              style: TextStyle(
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor),
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index].patientName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "\nDate : " +
                                                snapshot.data[index].aDateS
                                                    .substring(0, 10) +
                                                "\n\nReason : " +
                                                snapshot.data[index].reason,
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              "\nPatient is available at: " +
                                                  snapshot.data[index]
                                                      .availableTime +
                                                  "\n\nPatient is unavailable at: " +
                                                  snapshot.data[index]
                                                      .unavailableTime +
                                                  "\n\n",
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 20),
                                          _buildTime(snapshot
                                              .data[index].availableTime),
                                          SizedBox(height: 20),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              GestureDetector(
                                                //Submit button on registration password page
                                                child: new Container(
                                                    alignment: Alignment.center,
                                                    height: 45,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    decoration:
                                                        new BoxDecoration(
                                                            color:
                                                                Colors
                                                                    .green[900],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0)),
                                                    child: Text("Submit",
                                                        style: new TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.white))),
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      });

                                                  _timeKey.currentState.save();
                                                  Appointment a = Appointment();
                                                  a.time = timeSelected;
                                                  a.paymentAmount = snapshot
                                                      .data[index]
                                                      .paymentAmount;
                                                  a.aDateS = snapshot
                                                      .data[index].aDateS;
                                                  a.package = snapshot
                                                      .data[index].package;
                                                  a.reason = snapshot
                                                      .data[index].reason;
                                                  a.patientNumber = snapshot
                                                      .data[index]
                                                      .patientNumber;
                                                  a.doctorNumber = widget.dE;
                                                  a.paymentStatus = false;
                                                  DB().confirmAppointment(
                                                      widget.dE,
                                                      a.patientNumber,
                                                      a);
                                                  String input =
                                                      "Your appointment has been accepted and scheduled. Please pay doctors fees.";
                                                  DB().sendNotificationPatient(
                                                      snapshot.data[index]
                                                          .patientNumber,
                                                      input,
                                                      widget.dE);
                                                  Navigator.pop(context);
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "Appointment Accepted"),
                                                          content: Text(
                                                              "Processing"),
                                                          actions: [
                                                            FlatButton(
                                                              child: Text("OK"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Navigator.of(
                                                                        context)
                                                                    .popUntil(
                                                                        (route) =>
                                                                            route.isFirst);
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      });
                                                },
                                              ),
                                              SizedBox(width: 30),
                                              GestureDetector(
                                                //Submit button on registration password page
                                                child: new Container(
                                                    alignment: Alignment.center,
                                                    height: 45,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    decoration:
                                                        new BoxDecoration(
                                                            color:
                                                                Colors.red[900],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0)),
                                                    child: Text("Reject",
                                                        style: new TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.white))),
                                                onTap: () {
                                                  _timeKey.currentState.save();
                                                  String pN = snapshot
                                                      .data[index]
                                                      .patientNumber;
                                                  String date = snapshot
                                                      .data[index].aDateS;
                                                  DB().rejectAppointment(
                                                      widget.dE, pN, date);
                                                  Navigator.pop(context);
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "Appointment Rejected"),
                                                          content: Text(
                                                              "Processing"),
                                                          actions: [
                                                            FlatButton(
                                                              child: Text("OK"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Navigator.of(
                                                                        context)
                                                                    .popUntil(
                                                                        (route) =>
                                                                            route.isFirst);
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                            });
                      }),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _listViewUpcomingAppointments() {
    return FutureBuilder(
      future: DB().getUpcomingAppointmentsSpecific(widget.dE, widget.pE),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Loading();
        } else if (snapshot.data.length == 0) {
          return Container(
            height: 50,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "You've no Upcoming Appointments",
                  style: TextStyle(color: primaryColor, fontSize: 16),
                ),
              ),
            ),
          );
        } else {
          return Container(
            height: (snapshot.data.length) * 130.00,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int i) {
                return Divider(
                  color: Colors.transparent,
                );
              },
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: primaryColor, width: 2),
                  ),
                  child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      tileColor: Colors.white,
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("Images/doctor.png"),
                      ),
                      title: Text(
                        snapshot.data[index].patientName,
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Date : " +
                              snapshot.data[index].aDateS.substring(0, 10) +
                              "\nTime : " +
                              snapshot.data[index].time.toString() +
                              "\tReason : " +
                              snapshot.data[index].reason,
                          style: TextStyle(color: primaryColor, fontSize: 20),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  content: Stack(
                                overflow: Overflow.visible,
                                children: [
                                  Positioned(
                                    right: -15,
                                    top: -10,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: Colors.white,
                                        foregroundColor: primaryColor,
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Form(
                                      key: _notesKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 40, bottom: 40),
                                            child: Text(
                                              "Complete Appointment",
                                              style: TextStyle(
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor),
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index].patientName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "\nDate : " +
                                                snapshot.data[index].aDateS
                                                    .substring(0, 10) +
                                                "\n\nReason : " +
                                                snapshot.data[index].reason,
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          _buildNotes(),
                                          SizedBox(height: 10),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              GestureDetector(
                                                //Submit button on registration password page
                                                child: new Container(
                                                    alignment: Alignment.center,
                                                    height: 45,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    decoration:
                                                        new BoxDecoration(
                                                            color: primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0)),
                                                    child: Text(
                                                        "Complete Appointment",
                                                        style: new TextStyle(
                                                            fontSize: 20.0,
                                                            color:
                                                                Colors.white))),
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      });

                                                  _notesKey.currentState.save();
                                                  Appointment a = Appointment();
                                                  a.time = timeSelected;
                                                  a.aDateS = snapshot
                                                      .data[index].aDateS;
                                                  a.package = snapshot
                                                      .data[index].package;
                                                  a.reason = snapshot
                                                      .data[index].reason;
                                                  a.patientNumber = snapshot
                                                      .data[index]
                                                      .patientNumber;
                                                  a.doctorNumber = widget.dE;
                                                  a.notes = _notes;
                                                  DB().completeAppointment(
                                                      widget.dE,
                                                      a.patientNumber,
                                                      a);
                                                  Navigator.pop(context);
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          contect) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "Appointment Completed"),
                                                          content: Text(
                                                              "Processing"),
                                                          actions: [
                                                            FlatButton(
                                                              child: Text("OK"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Navigator.of(
                                                                        context)
                                                                    .popUntil(
                                                                        (route) =>
                                                                            route.isFirst);
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                            });
                      }),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _listViewPastAppoitments() {
    return FutureBuilder(
      future: DB().getPastAppointmentsSpecific(widget.dE, widget.pE),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Loading();
        } else if (snapshot.data.length == 0) {
          return Container(
            height: 50,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "You've no Completed Appointments",
                  style: TextStyle(color: primaryColor, fontSize: 16),
                ),
              ),
            ),
          );
        } else {
          return Container(
            height: (snapshot.data.length) * 130.00,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int i) {
                return Divider(
                  color: Colors.transparent,
                );
              },
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: primaryColor, width: 2),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    tileColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("Images/doctor.png"),
                    ),
                    title: Text(
                      snapshot.data[index].patientName,
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Date : " +
                            snapshot.data[index].aDateS.substring(0, 10) +
                            "\tReason : " +
                            snapshot.data[index].reason,
                        style: TextStyle(color: primaryColor, fontSize: 20),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content: Stack(
                              overflow: Overflow.visible,
                              children: [
                                Positioned(
                                  right: -15,
                                  top: -10,
                                  child: InkResponse(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: CircleAvatar(
                                      child: Icon(Icons.close),
                                      backgroundColor: Colors.white,
                                      foregroundColor: primaryColor,
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 40, bottom: 40),
                                        child: Text(
                                          "Notes",
                                          style: TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index].patientName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "\nNotes\n" +
                                            snapshot.data[index].notes,
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ));
                          });
                    },
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Theme(
          data: ThemeData(iconTheme: IconThemeData(color: Colors.black)),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Appointment Requests",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            _listViewRequestedAppointments(),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Upcomming Appointments",
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            _listViewUpcomingAppointments(),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Past Appointments",
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                textAlign: TextAlign.start,
              ),
            ),
            _listViewPastAppoitments(),
          ],
        ),
      ),
    );
  }
}
