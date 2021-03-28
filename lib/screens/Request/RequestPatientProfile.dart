import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/modals/Patient.dart';

class RequestPatientProfile extends StatelessWidget {
  final String phone;
  final Patient p;
  RequestPatientProfile(this.p, this.phone);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Request List",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Theme(
            data: ThemeData(iconTheme: IconThemeData(color: Colors.black)),
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
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Card(
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage("Images/profile picture.png"),
                ),
                Divider(),
                SizedBox(
                  height: 40,
                ),
                Text(
                  p.firstName + " " + p.lastName,
                  style: TextStyle(color: primaryColor, fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Height",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: FontWeight.bold)),
                Center(
                  child: Text(
                    p.height + " CM",
                    style: TextStyle(color: primaryColor, fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Weight",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: FontWeight.bold)),
                Center(
                  child: Text(
                    p.weight + " KG",
                    style: TextStyle(color: primaryColor, fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                          onPressed: () {
                            String input = "Doctor accepted your request";

                            DB().sendNotificationPatient(p.email, input, phone);
                            DB().acceptPatient(phone, p.email);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Message"),
                                    content: Text("Processing"),
                                    actions: [
                                      FlatButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          color: Colors.green[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text("Accept",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                          onPressed: () {
                            String input = "Doctor rejected your request";
                            DB().sendNotificationPatient(p.email, input, phone);
                            DB().rejectPatient(phone, p.email);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Message"),
                                    content: Text("Processing"),
                                    actions: [
                                      FlatButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).popUntil(
                                              (route) => route.isFirst);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          color: Colors.red[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text("Reject",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white))),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
