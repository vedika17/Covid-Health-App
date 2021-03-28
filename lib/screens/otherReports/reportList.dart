import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/screens/otherReports/patientOtherReports.dart';
import 'package:covid_health_app/screens/otherReports/viewOtherReports.dart';
import 'package:covid_health_app/widgets/Loading.dart';

class OtherReportList extends StatefulWidget {
  final String pE;

  OtherReportList(this.pE);

  @override
  _OtherReportListState createState() => _OtherReportListState();
}

class _OtherReportListState extends State<OtherReportList> {
  Color c;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          //padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
          //color: Colors.white,
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
                          builder: (context) => AddOtherReports(widget.pE)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add Other Reports",
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
            FutureBuilder(
                future: DB().viewOtherReports(widget.pE),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Loading();
                  } else if (snapshot.data.length == 0) {
                    return Container(
                      child: Center(
                        child: Text(
                          "You have not uploaded any reports yet",
                          style: TextStyle(
                            fontSize: 30,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: (snapshot.data.length) * 500.00,
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
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          "Date: " + snapshot.data[index].date,
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 10),
                                        child: Text(
                                          "Time: " + snapshot.data[index].time,
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Text(
                                      snapshot.data[index].type,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewOtherReports(
                                                        snapshot.data[index])));
                                      },
                                      color: primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      padding:
                                          EdgeInsets.fromLTRB(40, 10, 40, 10),
                                      child: Text("View Other Reports Image",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white))),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            );
                          }),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
