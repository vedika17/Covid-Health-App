import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/modals/OtherReports.dart';
import 'package:covid_health_app/modals/Prescription.dart';
import 'package:covid_health_app/widgets/Loading.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class ViewOtherReports extends StatefulWidget {
  final OtherReports or;

  ViewOtherReports(this.or);

  @override
  _ViewOtherReportsState createState() => _ViewOtherReportsState();
}

class _ViewOtherReportsState extends State<ViewOtherReports> {
  Color c;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Theme(
          data: ThemeData(iconTheme: IconThemeData(color: Colors.black)),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: primaryColor,
            ),
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
        child: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: primaryColor, width: 2),
            ),
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        "Date: " + widget.or.date,
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: Text(
                        "Time: " + widget.or.time,
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
                    widget.or.type,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
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
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      Center(
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: widget.or.imageLink,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  color: primaryColor,
                  onPressed: () {
                    Share.share(widget.or.imageLink);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
