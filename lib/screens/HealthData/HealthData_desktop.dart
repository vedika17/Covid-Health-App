import 'package:flutter/material.dart';
import 'package:covid_health_app/screens/HealthData/HealthData_mobile.dart';

class HealthDataDesktop extends StatelessWidget {
  final String phone;
  HealthDataDesktop(this.phone);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: HealthDataMobile(phone),
    );
  }
}
