import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid_health_app/constants/app_colors.dart';

class DoctorHomePage extends StatefulWidget {
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(overflow: Overflow.visible, children: [
                Container(
                  height: 140,
                  width: 140,
                  child: RaisedButton(
                    color: Colors.white,
                    textColor: primaryColor,
                    hoverColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: primaryColor, width: 3),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Icon(FontAwesomeIcons.userPlus,
                              size: 50, color: primaryColor),
                          SizedBox(height: 20),
                          Text(
                            "Requests",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (context) =>
                      //             Requests(phone)));
                    },
                  ),
                ),
                Positioned(
                  right: 15.0,
                  top: -15.0,
                  child: CircleAvatar(
                    radius: 15,
                    child: Text(
                      "2",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: primaryColor,
                  ),
                )
              ]),
              Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    child: RaisedButton(
                      color: Colors.white,
                      textColor: primaryColor,
                      hoverColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: primaryColor, width: 3),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(FontAwesomeIcons.users,
                                size: 50, color: primaryColor),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "My Patients",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     new MaterialPageRoute(
                        //         builder: (context) =>
                        //             RegisterForm(phone, _userType)));
                      },
                    ),
                  ),
                  Positioned(
                    right: 15.0,
                    top: -15.0,
                    child: CircleAvatar(
                      radius: 15,
                      child: Text(
                        "2",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: primaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    child: RaisedButton(
                      color: Colors.white,
                      textColor: primaryColor,
                      hoverColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: primaryColor, width: 3),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(FontAwesomeIcons.calendarAlt,
                                size: 50, color: primaryColor),
                            SizedBox(height: 20),
                            Text(
                              "Appointments",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     new MaterialPageRoute(
                        //         builder: (context) =>
                        //             Requests(phone)));
                      },
                    ),
                  ),
                  Positioned(
                    right: 15.0,
                    top: -15.0,
                    child: CircleAvatar(
                      radius: 15,
                      child: Text(
                        "2",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: primaryColor,
                    ),
                  ),
                ],
              ),
              Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    child: RaisedButton(
                      color: Colors.white,
                      textColor: primaryColor,
                      hoverColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: primaryColor, width: 3),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(FontAwesomeIcons.wallet,
                                size: 50, color: primaryColor),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Transactions",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     new MaterialPageRoute(
                        //         builder: (context) =>
                        //             RegisterForm(phone, _userType)));
                      },
                    ),
                  ),
                  Positioned(
                    right: 15.0,
                    top: -15.0,
                    child: CircleAvatar(
                      radius: 15,
                      child: Text(
                        "2",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: primaryColor,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
