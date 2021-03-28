import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/screens/otherReports/displayOtherReport.dart';

class AddOtherReports extends StatefulWidget {
  final String pE;
  AddOtherReports(this.pE);
  @override
  _AddOtherReportsState createState() => _AddOtherReportsState();
}

class _AddOtherReportsState extends State<AddOtherReports> {
  String notes, reportType, imageLink;
  var temp;
  File _image;

  Future getImage() async {
    final image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;
    });
  }

  Widget _buildImagePicker() {
    return (Center(
      child: new Column(
        children: [
          _image == null
              ? Text("Upload your report here",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ))
              : Image.file(_image, height: 350.0, width: 500.0),
          OutlineButton(
              color: primaryColor,
              onPressed: getImage,
              child: Icon(
                Icons.add_a_photo,
                color: primaryColor,
              )),
        ],
      ),
    ));
  }

  Widget _buildNotes() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Give notes",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.line_style),
          labelText: ("Notes regarding this report if any"),
        ),
        onSaved: (String value) {
          notes = value;
        },
        validator: (String value) {
          return value.contains('@') ? 'Do not use the @ char.' : null;
        },
      ),
    );
  }

  Widget _buildReportType() {
    return Material(
      child: Theme(
        data: ThemeData(primaryColor: primaryColor),
        child: DropdownButtonFormField(
            decoration: InputDecoration(
              hintText: "Report Type",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              prefixIcon: Icon(FontAwesomeIcons.fileMedical),
              labelText: ("Report Type"),
            ),
            items: [
              "Diabetese",
              "Blood Pressure",
              "Asthama",
            ]
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (String selected) {
              setState(() {
                reportType = selected;
              });
            }),
      ),
    );
  }

  final GlobalKey<FormState> _dFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _dFormKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                padding: EdgeInsets.all(20),
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              DisplayOtherReports(widget.pE)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View Uploaded Reports",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              _buildReportType(),
              SizedBox(height: 30),
              _buildImagePicker(),
              SizedBox(
                height: 10,
              ),
              Center(
                child: _image == null
                    ? Text('No Document Selected.',
                        style: TextStyle(color: Colors.red))
                    : Text(
                        "Document Selected",
                        style: TextStyle(color: Colors.green),
                      ),
              ),
              SizedBox(
                height: 30,
              ),
              _buildNotes(),
              SizedBox(height: 30),
              RaisedButton(
                color: primaryColor,
                padding: EdgeInsets.all(15),
                child: Text("Add Report",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                onPressed: () async {
                  if (_dFormKey.currentState.validate()) {
                    _dFormKey.currentState.save();
                  }
                  if (reportType == null) {
                    Widget okButton = FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                    AlertDialog alert = AlertDialog(
                      title: Text("Error"),
                      content: Text("Select Report Type"),
                      actions: [
                        okButton,
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
                  if (_image == null) {
                    Widget okButton = FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                    AlertDialog alert = AlertDialog(
                      title: Text("Error"),
                      content: Text("Please Select Prescription Receipt"),
                      actions: [
                        okButton,
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  } else {
                    FirebaseStorage fs = FirebaseStorage.instance;
                    StorageReference rootRef = fs.ref();
                    StorageReference pictureFolderRef = rootRef
                        .child("OtherReports")
                        .child(
                            widget.pE + reportType + DateTime.now().toString());
                    pictureFolderRef
                        .putFile(_image)
                        .onComplete
                        .then((storageTask) async {
                      String link = await storageTask.ref.getDownloadURL();
                      setState(() {
                        imageLink = link;
                        DB().addOtherReports(
                            widget.pE, imageLink, reportType, notes);
                      });
                    });
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Report uploaded"),
                            content: Text(
                                "You can view your reports in other reports tab"),
                            actions: [
                              FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              DisplayOtherReports(widget.pE)));
                                },
                              )
                            ],
                          );
                        });
                  }
                },
              )
            ]),
          )),
    ));
  }
}
