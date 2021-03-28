import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/widgets/Loading.dart';

import 'RequestPatientProfile.dart';

class RequestList extends StatefulWidget {
  final String phone;
  RequestList(this.phone);

  @override
  _RequestListState createState() => _RequestListState(phone);
}

class _RequestListState extends State<RequestList> {
  final String phone;

  _RequestListState(this.phone);

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
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
        color: Colors.white,
        child: FutureBuilder(
            future: DB().allRequested(phone),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Loading();
              } else if (snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: Text(
                      "No Request",
                      style: TextStyle(
                          fontSize: 20,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
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
                          contentPadding: EdgeInsets.all(15),
                          tileColor: Colors.white,
                          leading: CircleAvatar(
                              backgroundImage: AssetImage("Images/doctor.png")),
                          title: Text(
                            snapshot.data[index].firstName +
                                " " +
                                snapshot.data[index].lastName,
                            style: TextStyle(fontSize: 20, color: primaryColor),
                          ),
                          subtitle: Text(
                            snapshot.data[index].phone,
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
                                    builder: (context) => RequestPatientProfile(
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
