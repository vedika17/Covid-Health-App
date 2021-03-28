import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/modals/Patient.dart';
import 'package:covid_health_app/screens/SettingsAndPrivacy/PatientPage.dart';

class ViewProfile extends StatefulWidget {
  final String pE;
  final Patient p;
  ViewProfile(this.pE, this.p);

  @override
  _ViewProfileState createState() => _ViewProfileState(pE);
}

class _ViewProfileState extends State<ViewProfile> {
  final String pE;
  String firstName, lastName;
  String profilrLink;
  final FirebaseStorage storage = FirebaseStorage(
    app: Firestore.instance.app,
    storageBucket: "gs://menonhealthtest.appspot.com/",
  );
  Uint8List imageBytes;
  String errorMsg;
  File _image;

  _ViewProfileState(this.pE) {
    storage
        .ref()
        .child("ProfileImages/")
        .child(pE)
        .getData(10000000)
        .then((data) => setState(() {
              imageBytes = data;
            }))
        .catchError((e) => setState(() {
              errorMsg = e.error;
            }));
  }

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
              ? Text("Upload your profile picture",
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

  Widget _buildFName() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        controller: TextEditingController(text: widget.p.firstName),
        decoration: InputDecoration(
          hintText: "First Name",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.perm_identity),
          labelText: ("First Name"),
        ),
        onSaved: (value) {
          firstName = value;
        },
      ),
    );
  }

  Widget _buildLName() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        controller: TextEditingController(text: widget.p.lastName),
        decoration: InputDecoration(
          hintText: "Last Name",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.perm_identity),
          labelText: ("Last Name"),
        ),
        onSaved: (value) {
          lastName = value;
        },
      ),
    );
  }

  final GlobalKey<FormState> _fK = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var profileImage = imageBytes != null
        ? Image.memory(
            imageBytes,
            fit: BoxFit.cover,
          )
        : Text(errorMsg != null ? errorMsg : "Loading..");
    print(profileImage);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Theme(
          data: ThemeData(iconTheme: IconThemeData(color: primaryColor)),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: CircleAvatar(
                          //radius: 50,
                          minRadius: 30,
                          maxRadius: 50,
                          child: profileImage,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Text(
                                  "Change profile photo",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 10),
                                                    _buildImagePicker(),
                                                    Center(
                                                      child: _image == null
                                                          ? Text(
                                                              'No Document Selected.',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red))
                                                          : Text(
                                                              "Document Selected",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                    ),
                                                    RaisedButton(
                                                      color: primaryColor,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Text(
                                                        "Change Profile Photo",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      ),
                                                      onPressed: () async {
                                                        if (_image == null) {
                                                          Widget okButton =
                                                              FlatButton(
                                                            child: Text("OK"),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          );
                                                          AlertDialog alert =
                                                              AlertDialog(
                                                            title:
                                                                Text("Error"),
                                                            content: Text(
                                                                "Please upload your profile picture"),
                                                            actions: [
                                                              okButton,
                                                            ],
                                                          );
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return alert;
                                                            },
                                                          );
                                                          return null;
                                                        }
                                                        if (_image != null) {
                                                          FirebaseStorage fs =
                                                              FirebaseStorage
                                                                  .instance;
                                                          StorageReference
                                                              rootRef =
                                                              fs.ref();
                                                          StorageReference
                                                              pictureFolderRef =
                                                              rootRef
                                                                  .child(
                                                                      "ProfileImages")
                                                                  .child(pE);
                                                          pictureFolderRef
                                                              .putFile(_image)
                                                              .onComplete
                                                              .then(
                                                                  (storageTask) async {
                                                            String link =
                                                                await storageTask
                                                                    .ref
                                                                    .getDownloadURL();
                                                            profilrLink = link;
                                                          });
                                                        }
                                                        Widget okButton =
                                                            FlatButton(
                                                          child: Text("OK"),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        );
                                                        AlertDialog alert =
                                                            AlertDialog(
                                                          title: Text(
                                                              "Profile Photo updated"),
                                                          actions: [
                                                            okButton,
                                                          ],
                                                        );
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return alert;
                                                          },
                                                        );
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                              ),
                              SizedBox(width: 7),
                              Icon(
                                Icons.edit,
                                color: primaryColor,
                                size: 20,
                              )
                            ],
                          )),
                    ),
                    Form(
                      key: _fK,
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildFName(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildLName(),
                          ),
                          RaisedButton(
                            padding: EdgeInsets.all(8),
                            color: primaryColor,
                            child: Text(
                              "Save Changes",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () async {
                              if (!_fK.currentState.validate()) {
                                _fK.currentState.save();
                                print(firstName);
                                await DB()
                                    .updateNamePatient(pE, firstName, lastName);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Name changed successfully",
                                          style: TextStyle(color: primaryColor),
                                        ),
                                        actions: [
                                          FlatButton(
                                            child: Text("Okay",
                                                style: TextStyle(
                                                    color: primaryColor)),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          PatientProfilePage(
                                                              pE)));
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            },
                          )
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
