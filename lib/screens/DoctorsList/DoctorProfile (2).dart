import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/modals/Doctor.dart';

class DoctorProfile extends StatelessWidget {
  @required
  final Doctor d;
  final String phone;
  bool check;
  DoctorProfile(this.phone, this.d);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();

    final _db = FirebaseFirestore.instance;

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
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Card(
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
              Divider(),
              SizedBox(
                height: 40,
              ),
              Text("Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, color: primaryColor)),
              Text(
                "Dr." + d.firstName + " " + d.lastName,
                style: TextStyle(color: Colors.black, fontSize: 25),
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
              Text("Consultation Fee",
                  style: TextStyle(color: primaryColor, fontSize: 25)),
              Text(
                "Rs." + d.consultationFee.toString(),
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
              ),
              FlatButton(
                  onPressed: () async {
                    if (check) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Alert"),
                              content: Text("Already Requested"),
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
                    } else {
                      //sendMessage();
                      String input = "This patient is sends you a request";
                      await DB().sendNotification(d.email, input, phone);
                      var rt = await DB().sendRequest(d, phone);
                      print("Send Request: ");
                      print(rt);
                      if (rt == null)
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                      else if (rt) {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Alert"),
                                content: Text("Request Sent"),
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
                      }
                    }
                  },
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: FutureBuilder(
                      future: DB().isRequested(phone, d.phone),
                      builder: (BuildContext c, AsyncSnapshot ad) {
                        if (ad.data == null) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          );
                        } else if (ad.data == true) {
                          check = true;
                          return Text("Requested",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontFamily: "helvetic"));
                        } else {
                          check = false;
                          return Text("Send Request",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white));
                        }
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
