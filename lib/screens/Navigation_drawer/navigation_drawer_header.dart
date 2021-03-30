import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/screens/SettingsAndPrivacy/PatientPage.dart';
import 'package:covid_health_app/widgets/Loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawerHeader extends StatefulWidget {
  final String phone;

  NavigationDrawerHeader(this.phone);

  @override
  _NavigationDrawerHeaderState createState() =>
      _NavigationDrawerHeaderState(phone);
}

class _NavigationDrawerHeaderState extends State<NavigationDrawerHeader> {
  final String phone;
  String DocFname, DocLname;
  final FirebaseStorage storage = FirebaseStorage(
    app: Firestore.instance.app,
    storageBucket: "gs://menonhealthtest.appspot.com/",
  );
  Uint8List imageBytes;
  String errorMsg;

  _NavigationDrawerHeaderState(this.phone) {
    storage
        .ref()
        .child("ProfileImages/")
        .child(phone)
        .getData(10000000)
        .then((data) => setState(() {
              imageBytes = data;
            }))
        .catchError((e) => setState(() {
              errorMsg = e.error;
            }));
  }

  //var profileImage = new Image(
  //    image: new AssetImage('Images/profile picture.jpg'),
  //    height: 300,
  //    width: 200);

  @override
  Widget build(BuildContext context) {
    var profileImage = imageBytes != null
        ? Image.memory(imageBytes, fit: BoxFit.fill)
        : Text(errorMsg != null ? errorMsg : "Loading..");
    return Container(
      height: 150,
      color: primaryColor,
      alignment: Alignment.center,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20),
            child: Container(
              width: 70,
              height: 70,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  minRadius: 30,
                  maxRadius: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: profileImage,
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 20),
            child: GestureDetector(
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FutureBuilder(
                          future: DB().getUser(phone),
                          builder: (BuildContext context,
                              AsyncSnapshot asyncSnapshot) {
                            if (asyncSnapshot.data == null) {
                              print(phone);
                              print("Loading Hearder name");
                              return Loading();
                            } else {
                              var pd = asyncSnapshot.data;
                              DocFname = asyncSnapshot.data.firstName;
                              DocLname = asyncSnapshot.data.lastName;
                              print("in reading book pos");
                              print(DocFname);
                              MyFun();
                              return Text(
                                asyncSnapshot.data.firstName +
                                    " " +
                                    asyncSnapshot.data.lastName,
                                style: TextStyle(color: Colors.white),
                              );
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'User Profile',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => PatientProfilePage(phone)));
                    },
                  )
                ],
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  void MyFun() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("DocFname", DocFname);
    preferences.setString("DocLname", DocLname);
  }
}
