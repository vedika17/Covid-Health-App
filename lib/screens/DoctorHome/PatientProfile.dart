import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/modals/Patient.dart';
import 'package:covid_health_app/screens/DoctorHome/AppointmnetSpecific.dart';
import 'package:covid_health_app/screens/Prescription/addPrescription.dart';
import 'package:covid_health_app/screens/Reports/ReportPatientDoctor.dart';
import 'package:covid_health_app/screens/otherReports/displayOtherReport.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientProfile extends StatelessWidget {
  final Patient p;
  final String phone;

  PatientProfile(this.p, this.phone);

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
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: primaryColor, width: 2),
          ),
          elevation: 10,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("Images/doctor.png"),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Container(
                          height: 100,
                          width: 130,
                          child: RaisedButton(
                            color: Colors.white,
                            textColor: primaryColor,
                            hoverColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Colors.white, width: 1),
                            ),
                            // shape: Border.all(color: primaryColor, width: 3),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Icon(FontAwesomeIcons.calendarAlt,
                                      size: 40, color: primaryColor),
                                  SizedBox(height: 10),
                                  Text(
                                    "       View Appointments",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
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
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AppointmentSpecific(p.email, phone)));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name : " + p.firstName + " " + p.lastName,
                          style: TextStyle(color: primaryColor, fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Category : " + p.covidStatus,
                          style: TextStyle(color: primaryColor, fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Height : " + p.height + " CM",
                          style: TextStyle(color: primaryColor, fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Weight : " + p.weight + " KG",
                          style: TextStyle(color: primaryColor, fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          child: Text(
                            "Phone : " + p.phone,
                            style: TextStyle(color: primaryColor, fontSize: 16),
                          ),
                          onTap: () {
                            launch("tel:" + p.phone);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Email : " + p.email,
                          style: TextStyle(color: primaryColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 120,
                        width: 150,
                        child: RaisedButton(
                          color: Colors.white,
                          textColor: primaryColor,
                          hoverColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: primaryColor, width: 1),
                          ),
                          // shape: Border.all(color: primaryColor, width: 3),
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
                                  "Health Trend",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
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
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ReportListDoctor(p.email, phone)));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 120,
                        width: 150,
                        child: RaisedButton(
                          color: Colors.white,
                          textColor: primaryColor,
                          hoverColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: primaryColor, width: 1),
                          ),
                          // shape: Border.all(color: primaryColor, width: 3),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(Icons.assignment_outlined,
                                    size: 60, color: primaryColor),
                                SizedBox(height: 10),
                                Text(
                                  "Prescription",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
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
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PrescriptionData(p.email, phone)));
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 120,
                        width: 150,
                        child: RaisedButton(
                          color: Colors.white,
                          textColor: primaryColor,
                          hoverColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: primaryColor, width: 1),
                          ),
                          // shape: Border.all(color: primaryColor, width: 3),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(FontAwesomeIcons.fileMedical,
                                    size: 50, color: primaryColor),
                                SizedBox(height: 20),
                                Text(
                                  "Other Reports",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
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
                                        DisplayOtherReports(p.email)));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        height: 120,
                        width: 150,
                        child: RaisedButton(
                          color: Colors.white,
                          textColor: primaryColor,
                          hoverColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: primaryColor, width: 1),
                          ),
                          // shape: Border.all(color: primaryColor, width: 3),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(FontAwesomeIcons.wallet,
                                    size: 50, color: primaryColor),
                                SizedBox(height: 20),
                                Text(
                                  "Transactions",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     new MaterialPageRoute(
                            //         builder: (context) =>
                            //             HealthDataMobileWeb(widget.phone)));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void MyFun() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("phone", p.phone);
  }
}
