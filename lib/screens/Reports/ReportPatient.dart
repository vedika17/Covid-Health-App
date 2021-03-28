import 'package:condition/condition.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/modals/HealthDataEntry.dart';
import 'package:covid_health_app/screens/HealthData/HeathDataWeb_Mob.dart';
import 'package:covid_health_app/screens/otherReports/patientOtherReports.dart';
import 'package:covid_health_app/widgets/Loading.dart';

class ReportList extends StatefulWidget {
  final String phone;

  ReportList(this.phone);

  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  Color c;
  List<HealthDataEntry> h;
  var iconTod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
        color: Colors.white,
        child: FutureBuilder(
            future: DB().readHealthData(widget.phone),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print("Future Builder");
              if (snapshot.data == null) {
                return Loading();
              } else if (snapshot.data.length == 0) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No Health Records!!",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 30)),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        HealthDataMobileWeb(widget.phone)));
                          },
                          color: primaryColor,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Add Health Report",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            "Terms : \n"
                            "T : Temperature (°F)\n"
                            "O : Oxygen (SpO2)\n"
                            "P : Pulse (BPM)\n",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height / 6,
                              child: RaisedButton(
                                padding: EdgeInsets.all(10),
                                color: primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              AddOtherReports(widget.phone)));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Add Other\nReports",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Icon(Icons.add_circle_outline_sharp,
                                        color: Colors.white, size: 22),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: ListView.separated(
                            separatorBuilder: (BuildContext context, int i) {
                              return Divider(
                                color: Colors.transparent,
                              );
                            },
                            padding: EdgeInsets.all(10),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              var tod = int.parse(snapshot.data[index].date
                                  .toString()
                                  .substring(11, 13));
                              return Card(
                                color: (int.parse(snapshot.data[index].pulse) >
                                            100 ||
                                        int.parse(snapshot.data[index].pulse) <
                                            60 ||
                                        int.parse(snapshot
                                                .data[index].temprature) >
                                            101 ||
                                        int.parse(snapshot.data[index].oxy) <
                                            94)
                                    ? Colors.yellow[200]
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side:
                                      BorderSide(color: primaryColor, width: 2),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(10),
                                  tileColor: Colors.transparent,
                                  title: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Text(
                                          snapshot.data[index].date
                                                  .toString()
                                                  .substring(8, 10) +
                                              "/" +
                                              snapshot.data[index].date
                                                  .toString()
                                                  .substring(5, 7),
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        //Enter the icon for morning and evening and afternoon
                                        //       var tod = int.parse(snapshot.data[index].date
                                        //           .toString()
                                        //           .substring(11, 13));
                                        Conditioned(
                                          cases: [
                                            Case(tod >= 5 && tod < 12,
                                                builder: () => Icon(
                                                      Icons.wb_twighlight,
                                                      color: Colors.yellow[300],
                                                    )),
                                            Case(tod >= 12 && tod < 17,
                                                builder: () => Icon(
                                                      Icons.wb_sunny,
                                                      color: Colors.orange[600],
                                                    )),
                                            Case(
                                                (tod >= 17 && tod < 24) ||
                                                    (tod >= 0 && tod < 5),
                                                builder: () => Icon(
                                                      Icons.nights_stay,
                                                      color: Colors.blue[900],
                                                    )),
                                          ],
                                          defaultBuilder: () => Icon(
                                            FontAwesomeIcons.heart,
                                            color: Colors.grey[400],
                                            size: 35,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "O : " + snapshot.data[index].oxy,
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.blue),
                                        ),
                                        Text(
                                          " | ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: primaryColor),
                                        ),
                                        Text(
                                          "P : " + snapshot.data[index].pulse,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.green),
                                        ),
                                        Text(
                                          " | ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: primaryColor),
                                        ),
                                        Text(
                                          "T : " +
                                              snapshot.data[index].temprature,
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    HealthDataEntry he = snapshot.data[index];
                                    print(he.cold);
                                    var alertDialog = AlertDialog(
                                      title: Text(
                                        "Other Symptoms",
                                        style:
                                            TextStyle(color: Colors.lightBlue),
                                      ),
                                      content: Text("Cold    : " +
                                          he.cold +
                                          "\nCough : " +
                                          he.cough +
                                          "\nLoss of Taste : " +
                                          he.lossofTaste +
                                          "\nLoss of Smell : " +
                                          he.lossofSmell +
                                          "\nOther   : " +
                                          he.other),
                                    );

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alertDialog;
                                        });
                                  },
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
