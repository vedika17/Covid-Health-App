import 'package:flutter/material.dart';

class PatientReportTable extends StatefulWidget {
  final String phone;
  PatientReportTable(this.phone);
  @override
  State<StatefulWidget> createState() {
    return _PatientReportTableState();
  }
}

class _PatientReportTableState extends State<PatientReportTable> {
  Widget bodyData() => DataTable(
          columns: <DataColumn>[
            DataColumn(
                label: Text("Date\n",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "To Display date"),
            DataColumn(
                label: Text("Time\n",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "To Display time"),
            DataColumn(
                label: Text("Pulse\n(bpm)",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "To Display Pulse"),
            DataColumn(
                label: Text("Oxygen\n   (%)",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "To Display Oxygen"),
            DataColumn(
                label: Text("Temp.\n   (°F)",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "To Display Body Temprature"),
            DataColumn(
                label: Text("Other\n",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "To Display other symptoms of covid-19"),
          ],
          rows: names
              .map((name) => DataRow(cells: [
                    DataCell(
                        Text(
                          name.date,
                          style: TextStyle(),
                        ),
                        showEditIcon: false),
                    DataCell(Text(name.time), showEditIcon: false),
                    DataCell(Text("   " + name.pulse), showEditIcon: false),
                    DataCell(Text("   " + name.oxygen), showEditIcon: false),
                    DataCell(Text("   " + name.temp), showEditIcon: false),
                    DataCell(
                        Text(name.view,
                            style: TextStyle(color: Colors.lightBlue)),
                        showEditIcon: false, onTap: () {
                      var alertDialog = AlertDialog(
                        title: Text(
                          "Other Symptoms",
                          style: TextStyle(color: Colors.lightBlue),
                        ),
                        content: Text("Cold    : " +
                            name.cold +
                            "\nCough : " +
                            name.cough +
                            "\nOther   : " +
                            name.other),
                      );

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alertDialog;
                          });
                    }),
                  ]))
              .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table Data"),
      ),
      body: Container(
        child: bodyData(),
      ),
    );
  }
}

class Name {
  String date, time;
  String pulse, oxygen, temp, view;
  String cold, cough, other;

  Name(
      {this.date,
      this.time,
      this.pulse,
      this.oxygen,
      this.temp,
      this.view,
      this.cold,
      this.cough,
      this.other});
}

var names = <Name>[
  Name(
      date: "1/9/20",
      time: "9:30am",
      pulse: "88",
      oxygen: "98",
      temp: "96",
      view: "view",
      cold: "Yes",
      cough: "No",
      other: "tiredness & fever"),
  Name(
      date: "1/9/20",
      time: "9:30pm",
      pulse: "86",
      oxygen: "97",
      temp: "95",
      view: "view",
      cold: "No",
      cough: "Yes",
      other: "bit pian in neck"),
  Name(
      date: "2/9/20",
      time: "9:30am",
      pulse: "89",
      oxygen: "99",
      temp: "96",
      view: "view",
      cold: "No",
      cough: "No",
      other: "Not any pain"),
  Name(
      date: "3/9/20",
      time: "9:30am",
      pulse: "87",
      oxygen: "98",
      temp: "97",
      view: "view",
      cold: "No",
      cough: "Yes",
      other: "aches & pain"),
  Name(
      date: "4/9/20",
      time: "9:30am",
      pulse: "86",
      oxygen: "99",
      temp: "97",
      view: "view",
      cold: "Yes",
      cough: "No",
      other: "runny nose"),
];
