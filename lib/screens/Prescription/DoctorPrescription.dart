import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/widgets/Loading.dart';
import 'package:transparent_image/transparent_image.dart';
//import 'DoctorProfile.dart';

class DoctorPrescription extends StatefulWidget {
  final String pE;
  final String dE;

  DoctorPrescription(this.pE, this.dE);

  @override
  _DoctorPrescriptionState createState() => _DoctorPrescriptionState();
}

class _DoctorPrescriptionState extends State<DoctorPrescription> {
  Color c;

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
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
        color: Colors.white,
        child: FutureBuilder(
            future: DB().viewPrescriptionDoctor(widget.pE, widget.dE),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Loading();
              } else if (snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: Text(
                      "You have no prescriptions yet",
                      style: TextStyle(
                        fontSize: 30,
                        color: primaryColor,
                      ),
                    ),
                  ),
                );
              } else {
                return ListView.separated(
                    separatorBuilder: (BuildContext context, int i) {
                      return Divider(
                        color: Colors.transparent,
                      );
                    },
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: primaryColor, width: 2),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "Date: " + snapshot.data[index].date,
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 10, top: 10),
                                  child: Text(
                                    "Time: " + snapshot.data[index].time,
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Text(
                                "Prescription Image",
                                style: TextStyle(
                                    color: primaryColor, fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                  Center(
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: snapshot.data[index].imageLink,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Notes for patient: ",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: primaryColor, width: 2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  snapshot.data[index].notes,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Self Notes: ",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: primaryColor, width: 2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  snapshot.data[index].selfNotes,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
