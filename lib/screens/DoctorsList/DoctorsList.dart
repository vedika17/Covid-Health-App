import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/modals/Doctor.dart';
import 'package:covid_health_app/widgets/Loading.dart';

import 'DoctorProfile.dart';

class DoctordList extends StatefulWidget {
  final String phone;

  DoctordList(this.phone);

  @override
  _DoctordListState createState() => _DoctordListState();
}

class _DoctordListState extends State<DoctordList> {
  Color c;
  List<Doctor> doctors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
        color: Colors.white,
        child: FutureBuilder(
            future: DB().getDoctors(widget.phone),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                print("waiting for data doctor panel");
                return Loading();
              } else if (snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: Text("No doctors are using this Software"),
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
                          contentPadding: EdgeInsets.all(15),
                          tileColor: Colors.white,
                          leading: CircleAvatar(
                              backgroundColor: primaryColor,
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
                          trailing: Column(
                            children: [
                              Text(
                                "Consultation",
                                style: TextStyle(color: primaryColor),
                              ),
                              Text(
                                "Fees:",
                                style: TextStyle(color: primaryColor),
                              ),
                              Text(
                                //snapshot.data[index].consultationFee,
                                snapshot.data[index].consultationFee.toString(),
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => DoctorProfile(
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
