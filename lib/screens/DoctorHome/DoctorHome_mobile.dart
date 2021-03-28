import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:footer/footer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:covid_health_app/constants/app_colors.dart';
import 'package:covid_health_app/googleAuth/googleSignIn.dart';
import 'package:covid_health_app/screens/Navigation_drawer/navbar_item.dart';
import 'package:covid_health_app/screens/Navigation_drawer/navigation_drawer_header.dart';
import 'package:covid_health_app/screens/Scheduler/doctorAppointments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ContactUs.dart';
import 'DoctorHomePage.dart';

class DoctorHome extends StatefulWidget {
  final String phone;
  DoctorHome(this.phone);
  @override
  _DoctorHomeState createState() => _DoctorHomeState(phone);
}

class _DoctorHomeState extends State<DoctorHome> {
  final String phone; // Note: Here phone means email.
  _DoctorHomeState(this.phone);
  int i = 0;
  List<Widget> fragment = [];

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showMessage("Notification", "$message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        showMessage("Notification", "$message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        showMessage("Notification", "$message");
      },
    );

    super.initState();
  }

  showMessage(title, description) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(title),
            content: Text(description.toString()),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text("Dismiss"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    fragment = [
      DoctorHomePage(phone),
      DoctorAppointments(phone),
      // PatientList(phone),
      // Reports(phone),
      // Scheduler(phone),
      //PrescriptionData(),
      //PaymentList(phone),
      //CovidKITMobile(),
      //Chat(phone),
      ContactUs(),
      //addOtherReports(phone)
      // RequestList(phone),
    ];
    getDoc();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menon Health Tech",
          style: TextStyle(color: primaryColor),
        ),
        iconTheme: IconThemeData(color: primaryColor),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5.0,
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
      drawer: NavigationDrawer(
          phone: phone,
          onTap: (context, index) {
            Navigator.pop(context);
            setState(() {
              i = index;
            });
          }),
      body: fragment[i],
    );
  }

  void getDoc() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("DocPhone", phone);
  }
}

class NavigationDrawer extends StatelessWidget {
  final Function onTap;
  final String phone;

  NavigationDrawer({this.onTap, this.phone});

  Widget _buildAboutDisclaimer(BuildContext context) {
    return SingleChildScrollView(
      child: new RichText(
        text: new TextSpan(
          text:
              "Menon Health Tech Pvt Ltd is providing this platform for integrated product and services to patients. It is providing a centralized system to manage the patients. The objective is to integrate physical product and services such as homecare kit delivery of medicine with digital products and service such as data integration platform and tele-medicine consultation with doctors and physiologist. The company is providing Covid kit details, doctors pannel, data logging and emergency contacts. It is providing Covid information and the equipments user guide. The company is providing doctors name list with name, location and prices. The patients are free to add to the said list.\n\nThe Company website does not constitute an attempt to practice medicine and the use of the site does not establish a doctor-patient relationship. \n\nYou should exercise careful judgment about whether a product or service or information is likely to help you personally and you should, where appropriate, take independent advice. The Company makes no warranties or representations, express or implied as to the usefulness, fitness-for-purpose or quality of the products or services or information contained on this site. The Company is not responsible nor liable for any advice, course of treatment, diagnosis or any other information, services or products that you obtain through this web site.\n\nThe information contained in this transmission may contain privileged and confidential information, including patient information protected by laws applicable to it. It is intended only for the use of the person(s) i.e. the patient and the doctors. If you are not the intended recipient, you are hereby notified that any review, dissemination, distribution, or duplication of this communication is strictly prohibited.\n\nWhile the site attempts to be as accurate as possible, it should not be relied upon as being comprehensive or error-free. Company is under constant development and changes may be made in the articles and information at any time. The website reserves the right to change its disclaimer or privacy policy, so users should review these periodically. The information and material contained on this website is subject to change at any time, without notice.",
          style: TextStyle(color: primaryColor),
        ),
      ),
    );
  }

  Widget _buildDisclaimer(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        "Disclaimer",
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildAboutDisclaimer(context),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: new RaisedButton(
            color: primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Colors.white,
            child: const Text("Close"),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 16),
        ],
      ),
      child: Column(
        children: <Widget>[
          NavigationDrawerHeader(phone),
          ListTile(
            title: NavBarItem("Home Page"),
            leading: Icon(
              Icons.chat,
              size: 30,
            ),
            onTap: () => onTap(context, 0),
          ),
          // ListTile(
          //   title: NavBarItem("My Patients"),
          //   leading: Icon(
          //     Icons.chat,
          //     size: 30,
          //   ),
          //   onTap: () => onTap(context, 1),
          // ),
          // ListTile(
          //   title: NavBarItem("Reports"),
          //   leading: Icon(
          //     Icons.chat,
          //     size: 30,
          //   ),
          //   onTap: () => onTap(context, 1),
          // ),
          // ListTile(
          //   title: NavBarItem("Scheduler"),
          //   leading: Icon(
          //     Icons.chat,
          //     size: 30,
          //   ),
          //   onTap: () => onTap(context, 1),
          // ),
          ListTile(
            title: NavBarItem("Appointment"),
            leading: Icon(
              Icons.calendar_today,
              size: 30,
            ),
            onTap: () => onTap(context, 1),
          ),
          //ListTile(
          //  title: NavBarItem("Place Order"),
          //  leading: Icon(
          //    Icons.chat,
          //    size: 30,
          //  ),
          //  onTap: () => onTap(context, 4),
          //),
          //ListTile(
          //  title: NavBarItem("Chat"),
          //  leading: Icon(
          //    Icons.chat,
          //    size: 30,
          //  ),
          //  onTap: () => onTap(context, 4),
          //),
          ListTile(
            title: NavBarItem("Contact Us"),
            leading: Icon(
              Icons.contact_phone,
              size: 30,
            ),
            onTap: () => onTap(context, 2),
          ),
          ListTile(
            title: NavBarItem("Sign Out"),
            leading: Icon(
              Icons.logout,
              size: 30,
            ),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Do you want to sign out?",
                        style: TextStyle(color: primaryColor),
                      ),
                      actions: <Widget>[
                        RaisedButton(
                          color: primaryColor,
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            print("Sign out tapped");
                            final GoogleSignIn googleSignIn = GoogleSignIn();
                            await googleSignIn.disconnect();
                            await googleSignIn.signOut();
                            Navigator.pushReplacement(context,
                                new MaterialPageRoute(builder: (context) {
                              return GoogleSign();
                            }));
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        RaisedButton(
                          color: Colors.white,
                          child: Text(
                            "No",
                            style: TextStyle(color: primaryColor),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            },
          ),
          Footer(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              child: Text(
                "Disclaimer",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.grey,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildDisclaimer(context),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
