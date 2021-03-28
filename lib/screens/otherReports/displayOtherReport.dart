import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:flutter_share_file/flutter_share_file.dart';
import 'package:covid_health_app/screens/CovidKIT/CovidKIT_Mobile.dart';
import 'package:covid_health_app/screens/otherReports/patientOtherReports.dart';
import 'package:covid_health_app/widgets/Loading.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:url_launcher/url_launcher.dart';

class DisplayOtherReports extends StatefulWidget {
  final String pE;

  DisplayOtherReports(this.pE);

  @override
  _DisplayOtherReportsState createState() => _DisplayOtherReportsState();
}

class _DisplayOtherReportsState extends State<DisplayOtherReports> {
  Color c;

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
            future: DB().viewOtherReports(widget.pE),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Loading();
              } else if (snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: Text(
                      "No reports added",
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Date: " +
                                  snapshot.data[index].date +
                                  "\t\t\tTime: " +
                                  snapshot.data[index].time,
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                snapshot.data[index].type,
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                "Report Image",
                                style: TextStyle(
                                    color: primaryColor, fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                  Center(
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: snapshot.data[index].imageLink,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //RaisedButton(
                            //  onPressed: () async {
                            //    FlutterShareFile.share(
                            //        Image.network(
                            //            snapshot.data[index].imageLink),
                            //        "image.png",
                            //        ShareFileType.image);
                            //  },
                            //  child: new Text("share image"),
                            //),
                            SizedBox(
                              height: 40,
                            ),
                            FlatButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Are you sure you want to delete it?",
                                            style:
                                                TextStyle(color: primaryColor),
                                          ),
                                          actions: <Widget>[
                                            RaisedButton(
                                              color: primaryColor,
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                DB().deleteReport(widget.pE,
                                                    snapshot.data[index].docID);
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            "Report Deleted"),
                                                        actions: [
                                                          FlatButton(
                                                            child: Text("OK"),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          AddOtherReports(
                                                                              widget.pE)));
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            RaisedButton(
                                              color: Colors.white,
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                    color: primaryColor),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
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
                                child: Text("Delete Report",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white))),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
