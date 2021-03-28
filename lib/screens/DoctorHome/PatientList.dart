import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/widgets/Loading.dart';

import 'PatientProfile.dart';

class PatientList extends StatefulWidget {
  final String phone;
  PatientList(this.phone);

  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
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
        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
        color: Colors.white,
        child: FutureBuilder(
            future: DB().getPatient(widget.phone),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Loading();
              } else if (snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: Text(
                      "No Patients Yet",
                      style: TextStyle(
                        fontSize: 30,
                        color: primaryColor,
                      ),
                    ),
                  ),
                );
              } else {
                print(snapshot.data[0].firstName);
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
                          contentPadding: EdgeInsets.all(10),
                          tileColor: Colors.white,
                          leading: CircleAvatar(
                              backgroundImage: AssetImage("Images/doctor.png")),
                          title: Text(
                            snapshot.data[index].firstName +
                                " " +
                                snapshot.data[index].lastName,
                            style: TextStyle(
                                fontSize: 20,
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            snapshot.data[index].age + " years",
                            style: TextStyle(color: primaryColor),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward,
                            color: primaryColor,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => PatientProfile(
                                        snapshot.data[index],
                                        widget.phone))).then((value) {
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
