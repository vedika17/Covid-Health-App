import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CovidKITMobile extends StatefulWidget {
  final String phone;
  CovidKITMobile(this.phone);
  @override
  _CovidKITMobileState createState() => _CovidKITMobileState();
}

class _CovidKITMobileState extends State<CovidKITMobile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "Images/FinalDesign.png",
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Image(image: AssetImage('Images/medicines.png'))),
            Padding(
                padding: EdgeInsets.all(10),
                child: Image(image: AssetImage('Images/covidEssentials.png'))),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(20),
                    color: primaryColor,
                    onPressed: () {
                      launch("tel:8999964003");
                    },
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
