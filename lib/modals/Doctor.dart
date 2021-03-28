import 'dart:io';

class Doctor {
  String firstName,
      lastName,
      licenceNo,
      dateOfBirth,
      degree,
      phone,
      email,
      upiid,
      accountNo,
      ifsc,
      regNo,
      address,
      experience,
      fcmToken,
      profileImageLink,
      packageDays;
  File document;
  File profile;
  bool verified;
  int consultationFee, packageFee, followUpFee;

  Doctor(
      {this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.licenceNo,
      this.consultationFee,
      this.dateOfBirth,
      this.degree,
      this.accountNo,
      this.upiid,
      this.ifsc,
      this.regNo,
      this.verified,
      this.address,
      this.experience,
      this.document,
      this.profile,
      this.followUpFee,
      this.packageFee,
      this.profileImageLink,
      this.fcmToken,
      this.packageDays});
}
