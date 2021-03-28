import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EmergencyContactstate();
  }
}

class _EmergencyContactstate extends State<EmergencyContact> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "List View",
      home: Scaffold(body: getListView()),
    );
  }
}

Widget getListView() {
  var listview = ListView(
    children: <Widget>[
      ListTile(
        title: Text("Ambulance"),
        subtitle: Text("(+91)7038694912"),
        trailing: Icon(Icons.phone, color: primaryColor),
        onTap: () {
          launch("tel:7038694912");
        },
      ),
      Divider(
        color: Colors.grey,
      ),
      ListTile(
        title: Text("Blood bank"),
        subtitle: Text("(0231)2651640"),
        trailing: Icon(Icons.phone, color: primaryColor),
        onTap: () {
          launch("tel:02312651640");
        },
      ),
      Divider(
        color: Colors.grey,
      ),
      // ListTile(
      //   //contentPadding: EdgeInsets.all(5),
      //   focusColor: Colors.cyanAccent,
      //   title: Text("Ambulance"),
      //   subtitle: Text("(+91)9307473842"),
      //   trailing: Icon(Icons.phone, color: Colors.green),
      //   onTap: () {
      //     launch("tel:9307473842");
      //   },
      // ),
      // Divider(
      //   color: Colors.grey,
      // ),
      // ListTile(
      //   title: Text("Scan / X-ray"),
      //   subtitle: Text("(+91)9307473842"),
      //   trailing: Icon(Icons.phone, color: Colors.green),
      //   onTap: () {
      //     launch("tel:9307473842");
      //   },
      // ),
    ],
  );
  return listview;
}
