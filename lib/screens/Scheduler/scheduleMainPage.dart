import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/screens/Scheduler/scheduleDoctor.dart';
import 'package:covid_health_app/widgets/Loading.dart';

import 'appointmentPayment.dart';

class ScheduleMainPage extends StatefulWidget {
  final String phone;
  ScheduleMainPage(this.phone);

  @override
  _ScheduleMainPageState createState() => _ScheduleMainPageState(phone);
}

class _ScheduleMainPageState extends State<ScheduleMainPage> {
  String phone;

  _ScheduleMainPageState(String phone) {
    this.phone = phone;
  }

  Widget _listViewPendingPayments() {
    return FutureBuilder(
      future: DB().getPendingPayments(widget.phone),
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
                  "You've no Pending Payments",
                  style: TextStyle(color: primaryColor, fontSize: 16),
                ),
              ),
            ),
          );
        } else {
          return Container(
            height: (snapshot.data.length) * 150.00,
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
                      "Dr. " + snapshot.data[index].doctorName,
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "\nDate: " +
                          snapshot.data[index].aDateS.substring(0, 10) +
                          "\nTime: " +
                          snapshot.data[index].timeS.substring(10, 15),
                      style: TextStyle(color: primaryColor, fontSize: 15),
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          "Payment",
                          style: TextStyle(color: primaryColor),
                        ),
                        Text(
                          "Amount",
                          style: TextStyle(color: primaryColor),
                        ),
                        Text(
                          //snapshot.data[index].consultationFee,
                          "₹ " + snapshot.data[index].paymentAmount.toString(),
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    //onTap: () {
                    //  Navigator.push(
                    //      context,
                    //      new MaterialPageRoute(
                    //          builder: (context) => AppointmentPayment(
                    //              widget.phone,
                    //              snapshot.data[index].doctorNumber,
                    //              snapshot.data[index].paymentAmount,
                    //              snapshot.data[index].aDateS)));
                    //},
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _listViewUpcomingAppoitments() {
    return FutureBuilder(
      future: DB().getUpcomingAppointmentsPatient(widget.phone),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Loading();
        } else if (snapshot.data.length == 0) {
          return Container(
            height: 50,
            child: Center(
              child: Text(
                "You've no Upcoming Appointments",
                style: TextStyle(color: primaryColor, fontSize: 16),
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
                      "Dr. " + snapshot.data[index].doctorName,
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Date : " +
                            snapshot.data[index].aDateS.substring(0, 10) +
                            "\t\tTime : " +
                            snapshot.data[index].timeS.substring(10, 15) +
                            "\nReason : " +
                            snapshot.data[index].reason,
                        style: TextStyle(color: primaryColor, fontSize: 15),
                      ),
                    ),
                  ),
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
      future: DB().getPastAppointmentsPatient(widget.phone),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Loading();
        } else if (snapshot.data.length == 0) {
          return Container(
            height: 50,
            child: Center(
              child: Text(
                "You've no Past Appointments",
                style: TextStyle(color: primaryColor, fontSize: 16),
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
                      "Dr. " + snapshot.data[index].doctorName,
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Date : " +
                            snapshot.data[index].aDateS.substring(0, 10) +
                            "\nReason : " +
                            snapshot.data[index].reason,
                        style: TextStyle(color: primaryColor, fontSize: 15),
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
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Text(
                                          "This appointment is complete",
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            "Notes from doctor",
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Text(
                                            snapshot.data[index].notes,
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 18),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 6,
              child: RaisedButton(
                padding: EdgeInsets.all(20),
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ScheduleDoctor(widget.phone)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Schedule Appointmnet",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.add_circle_outline_sharp,
                        color: Colors.white, size: 30),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Pending Payments",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            _listViewPendingPayments(),
            SizedBox(
              height: 40,
            ),
            Text(
              "Upcomming Appointments",
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              textAlign: TextAlign.left,
            ),
            _listViewUpcomingAppoitments(),
            SizedBox(
              height: 40,
            ),
            Text(
              "Past Appointments",
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              textAlign: TextAlign.left,
            ),
            _listViewPastAppoitments(),
          ],
        ),
      ),
    );
  }
}
