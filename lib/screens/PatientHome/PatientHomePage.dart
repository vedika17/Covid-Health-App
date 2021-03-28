import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/screens/CovidKIT/CovidKIT_Mobile.dart';
import 'package:covid_health_app/screens/DoctorsList/DoctorsList.dart';
import 'package:covid_health_app/screens/EmergencyContact.dart';
import 'package:covid_health_app/screens/HealthData/HeathDataWeb_Mob.dart';
import 'package:covid_health_app/screens/MyDoctor/DoctorProfile.dart';
import 'package:covid_health_app/screens/Prescription/MyDoctors.dart';
import 'package:covid_health_app/screens/Reports/ReportPatient.dart';
import 'package:covid_health_app/screens/Scheduler/scheduleMainPage.dart';
import 'package:covid_health_app/widgets/Loading.dart';

import 'package:url_launcher/url_launcher.dart';

class PatientHomePage extends StatefulWidget {
  final String phone;

  PatientHomePage(this.phone);

  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  Widget homeMyDoctor(String phone) {
    return FutureBuilder(
        future: DB().getMyDoctor(widget.phone),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            print("Loading");
            return Loading();
          } else if (snapshot.data.length == 0) {
            return Container(
              width: 300,
              child: RaisedButton(
                padding: EdgeInsets.all(20),
                color: primaryColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => DoctordList(widget.phone)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add Doctor",
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
            );
          } else {
            print(snapshot.data.length);
            return Container(
              height: (snapshot.data.length) * 110.00,
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
                        contentPadding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        tileColor: Colors.white,
                        leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("Images/doctor.png")),
                        title: Text(
                          "Dr. " +
                              snapshot.data[index].firstName +
                              " " +
                              snapshot.data[index].lastName,
                          style: TextStyle(
                              fontSize: 16,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Degree: " + snapshot.data[index].degree,
                              style:
                                  TextStyle(color: primaryColor, fontSize: 14),
                            ),
                            Text(
                              "Experience: " + snapshot.data[index].experience,
                              style:
                                  TextStyle(color: primaryColor, fontSize: 14),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          color: primaryColor,
                          icon: Icon(Icons.phone),
                          onPressed: () {
                            launch("tel:" + snapshot.data[index].phone);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => MyDoctorProfile(
                                          widget.phone, snapshot.data[index])))
                              .then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    );
                  }),
            );
          }
        });
  }

  Widget homePrescription(String phone) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //button to see latest prescription
        Container(
          width: 160,
          child: RaisedButton(
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: primaryColor,
            onPressed: () {
              // Navigator.push(
              //     context,
              //     new MaterialPageRoute(
              //         builder: (context) => DoctordList(
              //             widget.phone)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Latest",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14),
                    ),
                    Text(
                      "Prescription",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.assignment_outlined, color: Colors.white, size: 30),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        //Add button to buy This prescription

        //Add button to See all the prescription
        Container(
          width: 105,
          child: RaisedButton(
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: primaryColor,
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          (MyDoctorPrescription(widget.phone))));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "See",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14),
                    ),
                    Text(
                      "All",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.assignment_outlined, color: Colors.white, size: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }

  var notificationcount = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            homeMyDoctor(widget.phone),
            SizedBox(
              height: 30,
            ),
            //ROW
            //add small icon to directly open latest prescription
            homePrescription(widget.phone),
            //add button to order COVID KIT
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(overflow: Overflow.visible, children: [
                  Container(
                    height: 140,
                    width: 170,
                    child: RaisedButton(
                      color: Colors.white,
                      textColor: primaryColor,
                      hoverColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: primaryColor, width: 3),
                      ),
                      // shape: Border.all(color: primaryColor, width: 3),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(FontAwesomeIcons.moneyCheck,
                                size: 50, color: primaryColor),
                            SizedBox(height: 20),
                            Text(
                              "Data Logging",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    HealthDataMobileWeb(widget.phone)));
                      },
                    ),
                  ),
                  Positioned(
                    right: 15.0,
                    top: -15.0,
                    child: (notificationcount == 0)
                        ? Text("")
                        : CircleAvatar(
                            radius: 15,
                            child: Text(
                              "$notificationcount",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: primaryColor,
                          ),
                  ),
                ]),
                SizedBox(
                  width: 30,
                ),
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      height: 140,
                      width: 170,
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: primaryColor,
                        hoverColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: primaryColor, width: 3),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Icon(FontAwesomeIcons.calendarAlt,
                                  size: 50, color: primaryColor),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Appointment",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      ScheduleMainPage(widget.phone)));
                        },
                      ),
                    ),
                    Positioned(
                      right: 15.0,
                      top: -15.0,
                      child: (notificationcount == 0)
                          ? Text("")
                          : CircleAvatar(
                              radius: 15,
                              child: Text(
                                "$notificationcount",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: primaryColor,
                            ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      height: 140,
                      width: 170,
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: primaryColor,
                        hoverColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: primaryColor, width: 3),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Icon(FontAwesomeIcons.chartLine,
                                  size: 50, color: primaryColor),
                              SizedBox(height: 20),
                              Text(
                                "Reports",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      ReportList(widget.phone)));
                        },
                      ),
                    ),
                    Positioned(
                      right: 15.0,
                      top: -15.0,
                      child: (notificationcount == 0)
                          ? Text("")
                          : CircleAvatar(
                              radius: 15,
                              child: Text(
                                "$notificationcount",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: primaryColor,
                            ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      height: 140,
                      width: 170,
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: primaryColor,
                        hoverColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: primaryColor, width: 3),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Icon(FontAwesomeIcons.wallet,
                                  size: 50, color: primaryColor),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Transactions",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     new MaterialPageRoute(
                          //         builder: (context) =>
                          //             RegisterForm(phone, _userType)));
                        },
                      ),
                    ),
                    Positioned(
                      right: 15.0,
                      top: -15.0,
                      child: (notificationcount == 0)
                          ? Text("")
                          : CircleAvatar(
                              radius: 15,
                              child: Text(
                                "$notificationcount",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: primaryColor,
                            ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      height: 140,
                      width: 170,
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: primaryColor,
                        hoverColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: primaryColor, width: 3),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Icon(FontAwesomeIcons.phoneAlt,
                                  size: 50, color: primaryColor),
                              SizedBox(height: 20),
                              Text(
                                "Place Order",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      CovidKITMobile(widget.phone)));
                        },
                      ),
                    ),
                    Positioned(
                      right: 15.0,
                      top: -15.0,
                      child: (notificationcount == 0)
                          ? Text("")
                          : CircleAvatar(
                              radius: 15,
                              child: Text(
                                "$notificationcount",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: primaryColor,
                            ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      height: 140,
                      width: 170,
                      child: RaisedButton(
                        color: Colors.white,
                        textColor: primaryColor,
                        hoverColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: primaryColor, width: 3),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Icon(FontAwesomeIcons.wallet,
                                  size: 50, color: primaryColor),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Emergency",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => EmergencyContact()));
                        },
                      ),
                    ),
                    Positioned(
                      right: 15.0,
                      top: -15.0,
                      child: (notificationcount == 0)
                          ? Text("")
                          : CircleAvatar(
                              radius: 15,
                              child: Text(
                                "$notificationcount",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: primaryColor,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
