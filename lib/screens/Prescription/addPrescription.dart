import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';

import 'DoctorPrescription.dart';

class PrescriptionData extends StatefulWidget {
  final String pE;
  final String dE;
  PrescriptionData(this.pE, this.dE);
  @override
  _PrescriptionDataState createState() => _PrescriptionDataState();
}

class _PrescriptionDataState extends State<PrescriptionData> {
  String notes, sNotes, imageLink;
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
              ? Text("Upload prescription image here",
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
          labelText: ("Prescription / Notes for Patient"),
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

  Widget _buildSNotes() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Give notes for self",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.line_style),
          labelText: ("Self Notes"),
        ),
        onSaved: (String value) {
          sNotes = value;
        },
        validator: (String value) {
          return value.contains('@') ? 'Do not use the @ char.' : null;
        },
      ),
    );
  }

  final GlobalKey<FormState> _dFormKey = GlobalKey<FormState>();

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
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(24),
              child: Form(
                key: _dFormKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        padding: EdgeInsets.all(20),
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => DoctorPrescription(
                                      widget.pE, widget.dE)));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View Previous Prescriptions",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
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
                      _buildSNotes(),
                      SizedBox(height: 30),
                      RaisedButton(
                        color: primaryColor,
                        padding: EdgeInsets.all(15),
                        child: Text("Add Prescription",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        onPressed: () async {
                          if (_dFormKey.currentState.validate()) {
                            _dFormKey.currentState.save();
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
                              content:
                                  Text("Please Select Prescription Receipt"),
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
                                .child("Prescription")
                                .child(widget.pE +
                                    "-" +
                                    widget.dE +
                                    "-" +
                                    DateTime.now().toString());
                            pictureFolderRef
                                .putFile(_image)
                                .onComplete
                                .then((storageTask) async {
                              String link =
                                  await storageTask.ref.getDownloadURL();
                              setState(() {
                                imageLink = link;
                                DB().addPrescription(widget.pE, widget.dE,
                                    imageLink, notes, sNotes);
                              });
                            });
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Prescription uploaded"),
                                    content: Text(
                                        "Patient can now view the prescription.\nYou can see the prescriptions in view prescription tab."),
                                    actions: [
                                      FlatButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      DoctorPrescription(
                                                          widget.pE,
                                                          widget.dE)));
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
