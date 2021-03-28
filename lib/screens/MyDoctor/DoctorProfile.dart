import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/modals/Doctor.dart';
import 'package:covid_health_app/screens/Prescription/PatientPrescription.dart';
import 'package:covid_health_app/screens/Prescription/PrescriptionList.dart';

class MyDoctorProfile extends StatelessWidget {
  @required
  final Doctor d;
  final String phone;
  MyDoctorProfile(this.phone, this.d);
  @override
  Widget build(BuildContext context) {
    Color c;
    String t;
    print(d.consultationFee);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Theme(
          data: ThemeData(iconTheme: IconThemeData(color: Colors.black)),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: primaryColor,
            ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("Images/doctor.png"),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Dr. " + d.firstName + " " + d.lastName,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  d.degree,
                  style: TextStyle(color: primaryColor, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text("First-time Consultation Fees:",
                  style: TextStyle(color: primaryColor, fontSize: 25)),
              Text("₹ " + d.consultationFee.toString(),
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text("Follow-up fees: ",
                  style: TextStyle(color: primaryColor, fontSize: 25)),
              Text("₹ " + d.followUpFee.toString(),
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 40,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PatientPrescriptionList(phone, d.email)));
                  },
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Text("View Prescription",
                      style: TextStyle(fontSize: 20, color: Colors.white))),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                  onPressed: () {
                    DB().deleteDoctor(phone, d.email);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Message"),
                            content: Text("Doctor Removed"),
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
                        });
                  },
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Text("Remove Doctor",
                      style: TextStyle(fontSize: 20, color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}
