import 'package:flutter/material.dart';

class Appointment {
  String doctorNumber,
      package,
      reason,
      patientNumber,
      patientName,
      doctorName,
      aDateS,
      availableTime,
      unavailableTime,
      timeS,
      notes,
      appointmentType,
      paymentID;
  DateTime aDate;
  TimeOfDay time;
  int paymentAmount;
  bool paymentStatus;

  Appointment(
      {this.doctorNumber,
      this.package,
      this.aDate,
      this.reason,
      this.patientNumber,
      this.patientName,
      this.doctorName,
      this.aDateS,
      this.time,
      this.availableTime,
      this.unavailableTime,
      this.notes,
      this.timeS,
      this.paymentID});
}
