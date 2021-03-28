/*import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menon/constants/app_colors.dart';
import 'package:menon/firestore/db.dart';
import 'package:menon/modals/Patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prescription extends StatefulWidget {
  final String phone;

  Prescription(this.phone);

  @override
  _PrescriptionState createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  String notes;
  var temp;
  web.File _image;

  Future getImage() async {
    web.InputElement uploadInput =  web.FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        _image = files[0];
        web.FileReader reader =  web.FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            temp = reader.result;
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            var st = "Some Error occured while reading the file";
          });
        });

        reader.readAsArrayBuffer(_image);
      }
    });
  }

  Widget _buildFName() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Add Prescription",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
            height: 8.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.perm_identity),
          labelText: ("Prescription / Notes"),
        ),
        onSaved: (String value) {
          notes = value;
        },
        validator: (String value) {
          return value.contains('@') ? 'Do not use the @ char.' : null;
        },
      ),
    );
  }

  Widget _buildImagePicker() {
    return (Center(
      child: new Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Upload Prescription note receipt",
              style: TextStyle(
                fontSize: 16,
                color: primaryColor,
              ),
            ),
          ),
          OutlineButton(
              color: primaryColor,
              onPressed: getImage,
              child: Icon(Icons.add_a_photo)),
        ],
      ),
    ));
  }

  final GlobalKey<FormState> _dFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(24),
            child: Form(
              key: _dFormKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildFName(),
                    SizedBox(height: 30),
                    _buildImagePicker(),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: _image == null
                          ? Text('No Document Selected.',
                          style: TextStyle(color: Colors.red))
                          : Text(
                        "Document Selected",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      color: primaryColor,
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Send",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_dFormKey.currentState.validate()) {
                          _dFormKey.currentState.save();
                        }
                        if (_image == null) {
                          Widget okButton = FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: Text("Error"),
                            content: Text("Please Select Prescription Receipt"),
                            actions: [
                              okButton,
                            ],
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        } else {

                          SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                          var pho = preferences.getString("phone");
                          String fname = preferences.getString("DocFname");
                          String lname = preferences.getString("DocLname");
                          String name = fname + " " + lname;
                          String doctName = fname+"_"+lname;
                          Patient p = Patient();
                          p.phone = pho;
                          p.Notes = notes;
                          p.Doctor = name;
                          print(notes);
                          var rt  = await DB().storePrescriptionImage(doctName,_image,pho,p);
                          //var rt = await DB().createPrescription(p);
                          if (rt) {
                            var alert = AlertDialog(
                              title: Text("Alert"),
                              content: Text("Data send successfully"),
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          } else {
                            var alert = AlertDialog(
                              title: Text("Alert"),
                              content: Text("Error:Data not send"),
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }
                        }

                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return Center(
                        //         child: CircularProgressIndicator(),
                        //       );
                        //     });
                        //String ph = getMyFun() as String;
                      },
                    )
                  ]),
            )));
  }

  void getMyFun() async {
    print('getMyFun() called');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var pho = preferences.getString("phone");
    //return pho;
  }
}*/
