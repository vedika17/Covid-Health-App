import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'HealthData_desktop.dart';
import 'HealthData_mobile.dart';

class HealthData extends StatelessWidget {
  final String phone;
  HealthData(this.phone);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) => //Scaffold(
//          backgroundColor: Colors.white,
//          body: CenteredView(
//          child: Column(
//            children: <Widget>[
//              if (sizingInformation.deviceScreenType == DeviceScreenType.desktop)
//                NavigationBar(),
            Expanded(
                child: ScreenTypeLayout(
              mobile: HealthDataMobile(phone),
              desktop: HealthDataDesktop(phone),
            ))
//            ],
        );
  }
}
