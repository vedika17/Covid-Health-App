import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';

class ContactUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactUsState();
  }
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Contact Us",
      home: Scaffold(body: getListView()),
    );
  }
}

Widget getListView() {
  var listview = ListView(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.phone_android),
        title: Text("Mobile Number"),
        subtitle: Text("(+91)8999964003"),
        trailing: Icon(Icons.phone, color: primaryColor),
        onTap: () {
          launch("tel:8999964003");
        },
      ),
      ListTile(
        leading: Icon(Icons.email),
        title: Text("Email ID"),
        subtitle: Text("healthtechmenon@gmail.com"),
        trailing: Icon(Icons.email, color: primaryColor),
        onTap: () {
          launch("mailto:healthtechmenon@gmail.com");
        },
      ),
    ],
  );
  return listview;
}
