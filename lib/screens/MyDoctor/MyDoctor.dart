import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/widgets/Loading.dart';

import 'package:url_launcher/url_launcher.dart';
import 'DoctorProfile.dart';

class MyDoctor extends StatefulWidget {
  final String phone;

  MyDoctor(this.phone);

  @override
  _MyDoctorState createState() => _MyDoctorState();
}

class _MyDoctorState extends State<MyDoctor> {
  Color c;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
        color: Colors.white,
        child: FutureBuilder(
            future: DB().getMyDoctor(widget.phone),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Loading();
              } else if (snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: Text(
                      "You have not added any Doctor Yet.",
                      style: TextStyle(
                        fontSize: 30,
                        color: primaryColor,
                      ),
                    ),
                  ),
                );
              } else {
                return ListView.separated(
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: primaryColor, width: 3),
                          ),
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage("Images/doctor.png")),
                          title: Text(
                            "Dr. " +
                                snapshot.data[index].firstName +
                                " " +
                                snapshot.data[index].lastName,
                            style: TextStyle(
                                fontSize: 20,
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Degree: " + snapshot.data[index].degree,
                                style: TextStyle(color: primaryColor),
                              ),
                              Text(
                                "Experience: " +
                                    snapshot.data[index].experience,
                                style: TextStyle(color: primaryColor),
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
                                        widget.phone,
                                        snapshot.data[index]))).then((value) {
                              setState(() {});
                            });
                          },
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
