import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/widgets/Loading.dart';

class readPrescription extends StatefulWidget {
  final String phone;

  readPrescription(this.phone);

  @override
  _readPrescriptionState createState() => _readPrescriptionState(phone);
}

class _readPrescriptionState extends State<readPrescription> {
  final String phone;

  _readPrescriptionState(this.phone);

  @override
  Widget build(BuildContext context) {
    // print(phone);
    //CollectionReference users = FirebaseFirestore.instance.collection('Patients').doc(phone).collection('prescription');
    return FutureBuilder(
        future: DB().getNotify(phone),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            print("Loading");
            return Loading();
          } else if (snapshot.data.length == 0) {
            print("nothing here");
            return Container(
              child: Center(
                child: Text(
                  "Nothing Here",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          } else {
            print(snapshot.data[0].Notes);
            return ListView.separated(
                separatorBuilder: (BuildContext context, int i) {
                  return Divider(
                    color: Colors.transparent,
                  );
                },
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10),
                    tileColor: primaryColor,
                    leading: CircleAvatar(
                        backgroundImage: AssetImage("Images/doctor.png")),
                    title: Text(
                      snapshot.data[index].Doctor,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    subtitle: Text(snapshot.data[index].date,
                        style: TextStyle(color: Colors.white)),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                    onTap: () {
                      /*  Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => PatientPaymentProfile(
                                  snapshot.data[index],
                                  widget.phone))).then((value) {
                        setState(() {});
                      });*/
                    },
                  );
                });
          }
        });
  }
}
