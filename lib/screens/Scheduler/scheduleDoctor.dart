import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/firestore/db.dart';
import 'package:covid_health_app/screens/Scheduler/scheduleForm.dart';
import 'package:covid_health_app/widgets/Loading.dart';

class ScheduleDoctor extends StatefulWidget {
  final String phone;
  ScheduleDoctor(this.phone);

  @override
  _ScheduleDoctorState createState() => _ScheduleDoctorState();
}

class _ScheduleDoctorState extends State<ScheduleDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
        color: Colors.white,
        child: FutureBuilder(
          future: DB().getMyDoctor(widget.phone),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Loading();
            } else if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: Text(
                    "You've not added any doctor yet",
                    style: TextStyle(color: primaryColor, fontSize: 20),
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
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: primaryColor, width: 3),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("Images/doctor.png"),
                      ),
                      title: Text(
                        "Dr. " +
                            snapshot.data[index].firstName +
                            " " +
                            snapshot.data[index].lastName,
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Text(
                            "First time consultation fees: ₹ " +
                                snapshot.data[index].consultationFee
                                    .toString() +
                                "\nFollow-up fees: ₹ " +
                                snapshot.data[index].followUpFee.toString(),
                            style:
                                TextStyle(color: primaryColor, fontSize: 16)),
                      ),
                      onTap: () {
                        print(widget.phone);
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => ScheduleForm(widget.phone,
                                    snapshot.data[index].email))).then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
