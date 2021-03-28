import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_health_app/modals/Appointment.dart';
import 'package:covid_health_app/modals/Doctor.dart';
import 'package:covid_health_app/modals/HealthDataEntry.dart';
import 'package:covid_health_app/modals/Orders.dart';
import 'package:covid_health_app/modals/Patient.dart';
import 'package:covid_health_app/modals/Prescription.dart';
import 'package:covid_health_app/modals/OtherReports.dart';

class DB {
  final _db = FirebaseFirestore.instance;

  Future<String> isWho(String email) async {
    print(email);
    QuerySnapshot data =
        await _db.collection("Doctor").where("email", isEqualTo: email).get();
    if (data.docs.length > 0) {
      print("iswho:doctor");
      return "Doctor";
    }
    data =
        await _db.collection("Patients").where("email", isEqualTo: email).get();
    if (data.docs.length > 0) {
      print("isWho: Patient");
      return "Patient";
    }
    print("New user");
    return "new";
  }

  Future<bool> createPatient(Patient patient, String pass) async {
    bool rt = false;

    // Auth().createUser(patient.phone, pass);
    try {
      await _db.collection("Patients").doc(patient.email).set({
        "firstName": patient.firstName[0].toUpperCase() +
            patient.firstName.substring(1).toLowerCase(),
        "lastName": patient.lastName[0].toUpperCase() +
            patient.lastName.substring(1).toLowerCase(),
        "phone": patient.phone,
        "email": patient.email,
        "height": patient.height,
        "weight": patient.weight,
        "Age": patient.age,
        "Date of Birth": patient.dob,
        "covidStatus": patient.covidStatus,
        "pass": pass,
        "fcmToken": patient.fcmToken
      });
      rt = true;
      print(rt);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      //prefs.setString('Number', patient.phone);
    } catch (e) {
      print(e.message);
    }
    return rt;
  }

  Future<bool> createDoctor(Doctor doctor, String pass) async {
    bool rt = false;
    try {
      await _db.collection("Doctor").doc(doctor.email).set({
        "firstName": doctor.firstName[0].toUpperCase() +
            doctor.firstName.substring(1).toLowerCase(),
        "lastName": doctor.lastName[0].toUpperCase() +
            doctor.lastName.substring(1).toLowerCase(),
        "phone": doctor.phone,
        "email": doctor.email,
        "degree": doctor.degree,
        "verifed": false,
        "upiid": doctor.upiid,
        "accountNo": doctor.accountNo,
        "ifsc": doctor.ifsc,
        "consultationFee": doctor.consultationFee,
        "pass": pass,
        "regNo": doctor.regNo,
        "address": doctor.address,
        "experience": doctor.experience,
        "followUpFee": doctor.followUpFee,
        "packageFee": doctor.packageFee,
        "fcmToken": doctor.fcmToken,
        "profileImageLink": doctor.profileImageLink,
      });

      /*try {
        //print(doctor.document.name);

        fb.storage()
            .refFromURL("gs://menonhealthtech.appspot.com")
            .child(
            doctor.firstName + "_" + doctor.lastName + "_" + doctor.phone)
            .put(doctor.document)
            .future;

        fb
            .storage()
            .refFromURL("gs://menonhealthtech.appspot.com")
            .child(doctor.phone)
            .put(doctor.profile)
            .future;
      } catch (e) {
        print("Cannot Upload Document");
        print(e);
      }*/

      //Auth().createUser(doctor.phone, pass);
      rt = true;
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //prefs.setString('Number', doctor.phone);
    } catch (e) {
      print("Cannot Register");
      print(e);
      rt = false;
    }
    return rt;
  }

  Future updateFCMToken(String email, String fcm) async {
    Future<String> user = isWho(email);
    try {
      print("updating token");
      if (user.toString() == "Doctor") {
        _db.collection("Doctor").doc(email).update({"fcmToken": fcm});
      } else if (user.toString() == "Patient") {
        _db.collection("Patients").doc(email).update({"fcmToke": fcm});
      }
    } catch (e) {
      print(e);
    }
  }

  Future getUser(String phone) async {
    Patient p = Patient();
    Doctor d = Doctor();
    try {
      var ss = await _db
          .collection("Patients")
          .where("email", isEqualTo: phone)
          .get();

      if (ss.docs.isNotEmpty) {
        var data = ss.docs[0].data();
        if (data != null) {
          p.firstName = data["firstName"];
          p.lastName = data["lastName"];
          p.gender = data["gender"];
          p.covidStatus = data["covidStatus"];
          p.weight = data["weight"];
          p.height = data["height"];
          p.age = data["age"];
          p.email = data["email"];
          p.phone = phone;
          return p;
        }
      }
      var dd =
          await _db.collection("Doctor").where("phone", isEqualTo: phone).get();
      if (dd.docs.isNotEmpty) {
        var data = dd.docs[0].data();
        if (data != null) {
          d.firstName = data["firstName"];
          d.lastName = data["lastName"];
          d.consultationFee = data["consultationFee"];
          d.degree = data["degree"];
          d.verified = data["verified"];
          d.email = data["email"];
          d.phone = phone;
          return d;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addHealthData(String phone, HealthDataEntry h) async {
    bool rt = false;
    try {
      await _db
          .collection("Patients")
          .doc(phone)
          .collection("HealthData")
          .doc(Timestamp.now().toDate().toString())
          .set({
        "Date": Timestamp.now().toDate().toString(),
        "Temprature": h.temprature,
        "Oxygen Level": h.oxy,
        "Pulse": h.pulse,
        "Cough": h.cough,
        "Cold": h.cold,
        "Cough Type": h.coughType,
        "Cough Severity": h.coughSevarity,
        "Loss of Smell": h.lossofSmell,
        "Loss of Taste": h.lossofTaste,
        "Other": h.other,
      });
      rt = true;
    } catch (e) {
      print(e.message);
    }
    return rt;
  }

  Future<List<HealthDataEntry>> readHealthData(String phone) async {
    List<HealthDataEntry> hs = List<HealthDataEntry>();
    print("Reading Data");
    try {
      QuerySnapshot data = await _db
          .collection("Patients")
          .doc(phone)
          .collection("HealthData")
          .orderBy("Date", descending: true)
          .get();

      data.docs.forEach((element) {
        var d = element.data();
        print(d);
        HealthDataEntry h = HealthDataEntry();
        h.cold = d["Cold"];
        h.cough = d["Cough"];
        h.temprature = d["Temprature"];
        h.lossofSmell = d["Loss of Smell"];
        h.lossofTaste = d["Loss of Taste"];
        // h.coughType = d["Cough Type"];
        // h.coughSevarity = d["Cough Severity"];
        h.pulse = d["Pulse"];
        h.other = d["Other"];
        h.oxy = d["Oxygen Level"];
        //h.dataTime = d["Date"];
        h.date = d["Date"].toString();

        hs.add(h);
        print(" inside DB ");
      });
    } catch (e) {
      print(e);
    }
    return hs;
  }

  Future getMyDoctor(String phone) async {
    List<Doctor> doctors = List<Doctor>();
    print(phone);
    DocumentSnapshot t;
    try {
      QuerySnapshot data = await _db
          .collection("Patients")
          .doc(phone)
          .collection("Doctors")
          .get();
      var doc = data.docs;

      for (var i = 0; i < doc.length; i++) {
        String p = doc[i].data()["DoctorNumber"];
        print(p);
        t = await _db.collection("Doctor").doc(p).get();
        Doctor da = Doctor();
        da.consultationFee = t.data()["consultationFee"];
        da.dateOfBirth = t.data()["dateOfBirth"];
        da.followUpFee = t.data()["followUpFee"];
        da.degree = t.data()["degree"];
        da.email = t.data()["email"];
        da.firstName = t.data()["firstName"];
        da.lastName = t.data()["lastName"];
        da.licenceNo = t.data()["licenceNo"];
        da.phone = t.data()["phone"];
        da.verified = t.data()["verifed"];
        da.experience = t.data()["experience"];
        doctors.add(da);
      }
    } catch (e) {
      print(e);
    }
    return doctors;
  }

  Future<List<Doctor>> getAllDoctors() async {
    List<Doctor> doctors = [];
    try {
      QuerySnapshot data = await _db.collection("Doctor").get();
      print("getting doctors");

      data.docs.forEach((element) {
        print("each element");
        var d = element.data();
        Doctor da = Doctor();
        print("Doctor created");
        da.consultationFee = d["consultationFee"];
        da.followUpFee = d["followUpFee"];
        da.degree = d["degree"];
        da.email = d["email"];
        da.firstName = d["firstName"];
        da.lastName = d["lastName"];
        da.licenceNo = d["regNo"];
        da.phone = d["phone"];
        da.verified = d["verifed"];
        da.experience = d["experience"];
        doctors.add(da);
      });
    } catch (e) {
      print(e.message);
      print("error");
    }
    return doctors;
  }

  Future sendNotificationPatient(String email, String input, String dE) async {
    try {
      DocumentSnapshot data = await _db.collection("Doctor").doc(dE).get();
      _db.collection("Patients").doc(email).collection("notifications").add({
        "message": input,
        "title":
            "Dr. " + data.data()["firstName"] + " " + data.data()["lastName"]
      });
    } catch (e) {
      print(e);
    }
  }

  Future sendNotification(String d, String input, String pE) async {
    try {
      DocumentSnapshot data = await _db.collection("Patients").doc(pE).get();
      _db.collection("Doctor").doc(d).collection("notification").add({
        "message": input,
        "title": data.data()["firstName"] + " " + data.data()["lastName"],
        "date": FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Doctor>> getDoctors(String phone) async {
    List<Doctor> all = List<Doctor>();
    try {
      QuerySnapshot data = await _db
          .collection("Patients")
          .doc(phone)
          .collection("Doctors")
          .get();
      var doc = data.docs;
      all = await getAllDoctors();
      print(all.length);
      if (doc.length == 0) return all;

      for (var i = 0; i < doc.length; i++) {
        print(all[i].phone);
        for (var j = 0; j < all.length; j++) {
          if (all[j].email == doc[i].data()["DoctorNumber"]) all.remove(all[j]);
        }
      }
    } catch (e) {
      print(e.message);
      print("error");
    }
    print(all.length);
    return all;
  }

  Future<Patient> getSinglePatient(String pE) async {
    DocumentSnapshot t;
    try {
      t = await _db.collection("Patients").doc(pE).get();
      Patient p = Patient();
      p.firstName = t.data()["firstName"];
      p.lastName = t.data()["lastName"];
      p.email = t.data()["email"];
      p.phone = t.data()["phone"];
      p.weight = t.data()["weight"];
      p.height = t.data()["height"];
      p.age = t.data()["Age"];
      p.covidStatus = t.data()["covidStatus"];
      p.aadharNo = t.data()["aadharNo"];
      p.pass = t.data()["pass"];
      return p;
    } catch (e) {
      print(e);
    }
  }

  Future updateNamePatient(String pE, String fName, String lName) async {
    try {
      await _db
          .collection("Patients")
          .doc(pE)
          .update({"firstName": fName, "lastName": lName});
    } catch (e) {
      print(e);
    }
  }

  Future updatePersonalInfo(String pE, Patient p) async {
    try {
      await _db.collection("Patients").doc(pE).update({
        "aadharNo": p.aadharNo,
        "height": p.height,
        "weight": p.weight,
        "covidStatus": p.covidStatus
      });
    } catch (e) {
      print(e);
    }
  }

  Future changepassword(String pE, String pass) async {
    try {
      print("inside change password");
      await _db.collection("Patients").doc(pE).update({"pass": pass});
    } catch (e) {
      print(e);
    }
  }

  Future<List<Patient>> getPatient(String docNumber) async {
    List<Patient> patients = [];
    DocumentSnapshot t;
    try {
      QuerySnapshot data = await _db
          .collection("Doctor")
          .doc(docNumber)
          .collection("Patients")
          .get();
      var doc = data.docs;

      for (var i = 0; i < doc.length; i++) {
        String d = doc[i].data()["PatientNumber"];
        t = await _db.collection("Patients").doc(d).get();
        Patient p = Patient();
        p.firstName = t.data()["firstName"];
        p.lastName = t.data()["lastName"];
        p.email = t.data()["email"];
        p.phone = t.data()["phone"];
        p.weight = t.data()["weight"];
        p.height = t.data()["height"];
        p.age = t.data()["Age"];
        p.covidStatus = t.data()["covidStatus"];
        patients.add(p);
      }
    } catch (e) {
      print(e.message);
    }
    return patients;
  }

  Future<bool> sendRequest(Doctor d, String pN) async {
    try {
      await _db
          .collection("Doctor")
          .doc(d.email)
          .collection("Request")
          .doc(pN)
          .set({
        "PatientNumber": pN,
        "Date Added": Timestamp.now().toDate().toString(),
      });
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("Requested")
          .doc(d.email)
          .set({
        "DoctorEmail": d.email,
        "DoctorNumber": d.phone,
        "Date Added": Timestamp.now().toDate().toString(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future acceptPatient(String dN, String pN) async {
    try {
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("Doctors")
          .doc(dN)
          .set({
        "DoctorNumber": dN,
        "Date Added": Timestamp.now().toDate().toString(),
      });
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("Requested")
          .doc(dN)
          .delete();
    } catch (e) {
      return false;
    }
    try {
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("Patients")
          .doc(pN)
          .set({
        "PatientNumber": pN,
        "Date Added": Timestamp.now().toDate().toString(),
      });
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("Request")
          .doc(pN)
          .delete();
    } catch (e) {
      return false;
    }
    return true;
  }

  Future rejectPatient(String dN, String pN) async {
    try {
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("Request")
          .doc(pN)
          .delete();
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("Requested")
          .doc(dN)
          .delete();
      return true;
    } catch (e) {
      print(e);
    }
    return;
  }

  Future deleteDoctor(String pN, String dN) async {
    try {
      print("Deleting ");
      print(pN);
      print(dN);
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("Doctors")
          .doc(dN)
          .delete();
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("Patient")
          .doc(pN)
          .delete();
    } catch (e) {}
  }

  Future<bool> isRequested(String pN, String dN) async {
    print(pN);
    print(dN);
    try {
      QuerySnapshot data = await _db
          .collection("Patients")
          .doc(pN)
          .collection("Requested")
          .where("DoctorNumber", isEqualTo: dN)
          .get();

      if (data.docs.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Patient>> allRequested(String dN) async {
    List<Patient> patients = [];
    print("in all request");
    print(dN);
    DocumentSnapshot t;
    try {
      QuerySnapshot data =
          await _db.collection("Doctor").doc(dN).collection("Request").get();
      var doc = data.docs;

      for (var i = 0; i < doc.length; i++) {
        String ph = doc[i].data()["PatientNumber"];
        print("Email here!!");
        print(ph);
        t = await _db.collection("Patients").doc(ph).get();
        Patient p = Patient();
        p.firstName = t.data()["firstName"];
        p.lastName = t.data()["lastName"];
        p.email = t.data()["email"];
        p.phone = t.data()["phone"];
        p.weight = t.data()["weight"];
        p.height = t.data()["height"];
        print("p.email");
        print(p.email);
        patients.add(p);
      }

      return patients;
    } catch (e) {
      return null;
    }
  }

  Future<bool> addOtherReports(
      String pE, String imageLink, String reportType, String notes) async {
    try {
      await _db
          .collection("Patients")
          .doc(pE)
          .collection("otherReports")
          .doc(reportType + "-" + DateTime.now().toString())
          .set({
        "ImageLink": imageLink,
        "ReportType": reportType,
        "Notes": notes,
        "Date": Timestamp.now().toDate().toString()
      });
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<List<OtherReports>> viewOtherReports(String pE) async {
    List<OtherReports> reports = List<OtherReports>();
    try {
      QuerySnapshot data = await _db
          .collection("Patients")
          .doc(pE)
          .collection("otherReports")
          .orderBy("Date", descending: true)
          .get();
      data.docs.forEach((element) {
        var d = element.data();
        OtherReports or = OtherReports();
        or.docID = element.id;
        or.imageLink = d["ImageLink"];
        or.date = d["Date"].toString().substring(0, 10);
        or.time = d["Date"].toString().substring(11, 16);
        or.type = d["ReportType"];
        reports.add(or);
      });
    } catch (e) {
      print(e);
    }
    return reports;
  }

  Future deleteReport(String pE, String id) async {
    try {
      print("Deleting Report");
      await _db
          .collection("Patients")
          .doc(pE)
          .collection("otherReports")
          .doc(id)
          .delete();
    } catch (e) {}
  }

  Future<bool> addPrescription(
      String pE, String dE, String link, String notes, String selfNotes) async {
    try {
      await _db
          .collection("Doctor")
          .doc(dE)
          .collection("Patients")
          .doc(pE)
          .collection("Prescription")
          .doc(DateTime.now().toString())
          .set({
        "ImageLink": link,
        "Notes": notes,
        "SelfNotes": selfNotes,
        "Date": Timestamp.now().toDate().toString()
      });
    } catch (e) {
      print(e);
    }
    try {
      await _db
          .collection("Patients")
          .doc(pE)
          .collection("Doctors")
          .doc(dE)
          .collection("Prescription")
          .doc(DateTime.now().toString())
          .set({
        "ImageLink": link,
        "Notes": notes,
        "Date": Timestamp.now().toDate().toString()
      });
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<List<Prescription>> viewPrescription(String pE, String dE) async {
    List<Prescription> prescription = List<Prescription>();
    try {
      QuerySnapshot data = await _db
          .collection("Patients")
          .doc(pE)
          .collection("Doctors")
          .doc(dE)
          .collection("Prescription")
          .orderBy("Date", descending: true)
          .get();
      data.docs.forEach((element) {
        var d = element.data();
        Prescription p = Prescription();
        p.imageLink = d["ImageLink"];
        p.notes = d["Notes"];
        p.date = d["Date"].toString().substring(0, 10);
        print(p.date);
        p.time = d["Date"].toString().substring(11, 16);
        prescription.add(p);
      });
    } catch (e) {
      print(e);
    }
    return prescription;
  }

  Future<List<Prescription>> viewPrescriptionDoctor(
      String pE, String dE) async {
    List<Prescription> prescription = List<Prescription>();
    try {
      QuerySnapshot data = await _db
          .collection("Doctor")
          .doc(dE)
          .collection("Patients")
          .doc(pE)
          .collection("Prescription")
          .orderBy("Date", descending: true)
          .get();
      data.docs.forEach((element) {
        var d = element.data();
        Prescription p = Prescription();
        p.imageLink = d["ImageLink"];
        p.notes = d["Notes"];
        p.date = d["Date"].toString().substring(0, 10);
        p.time = d["Date"].toString().substring(11, 16);
        p.selfNotes = d["SelfNotes"];
        prescription.add(p);
      });
    } catch (e) {
      print(e);
    }
    return prescription;
  }

  Future getRequetedAppointments(String phone) async {
    List<Appointment> appointments = List<Appointment>();
    DocumentSnapshot t;
    try {
      QuerySnapshot data = await _db
          .collection("Doctor")
          .doc(phone)
          .collection("AppointmentRequests")
          .get();
      var doc = data.docs;
      for (var i = 0; i < doc.length; i++) {
        String p = doc[i].data()["PatientNumber"];
        t = await _db.collection("Patients").doc(p).get();
        Appointment a = Appointment();
        a.patientName = t.data()["firstName"] + " " + t.data()["lastName"];
        a.aDateS = doc[i].data()["Date"];
        a.patientNumber = doc[i].data()["PatientNumber"];
        a.reason = doc[i].data()["Reason"];
        a.package = doc[i].data()["Package"];
        a.paymentAmount = doc[i].data()["PaymentAmount"];
        a.availableTime = doc[i].data()["AvailableTime"];
        a.unavailableTime = doc[i].data()["UnavilableTime"];
        a.appointmentType = doc[i].data()["AppointmentType"];
        appointments.add(a);
      }
    } catch (e) {
      print("errorE");
      print(e);
    }
    return appointments;
  }

  Future getRequetedAppointmentsSpecific(String dE, String pE) async {
    List<Appointment> appointments = List<Appointment>();
    DocumentSnapshot t;
    try {
      QuerySnapshot data = await _db
          .collection("Doctor")
          .doc(dE)
          .collection("AppointmentRequests")
          .get();
      var doc = data.docs;
      for (var i = 0; i < doc.length; i++) {
        String p = doc[i].data()["PatientNumber"];
        if (p == pE) {
          t = await _db.collection("Patients").doc(p).get();
          Appointment a = Appointment();
          a.patientName = t.data()["firstName"] + " " + t.data()["lastName"];
          a.aDateS = doc[i].data()["Date"];
          a.patientNumber = doc[i].data()["PatientNumber"];
          a.reason = doc[i].data()["Reason"];
          a.package = doc[i].data()["Package"];
          a.paymentAmount = doc[i].data()["PaymentAmount"];
          a.availableTime = doc[i].data()["AvailableTime"];
          a.unavailableTime = doc[i].data()["UnavilableTime"];
          a.appointmentType = doc[i].data()["AppointmentType"];
          appointments.add(a);
        }
      }
    } catch (e) {
      print("errorE");
      print(e);
    }
    return appointments;
  }

  Future getUpcomingAppointments(String phone) async {
    List<Appointment> appointments = List<Appointment>();
    DocumentSnapshot t;
    try {
      QuerySnapshot data = await _db
          .collection("Doctor")
          .doc(phone)
          .collection("Appointment")
          .get();
      var doc = data.docs;
      for (var i = 0; i < doc.length; i++) {
        bool status = doc[i].data()["PaymentStatus"];
        if (status == true) {
          String p = doc[i].data()["PatientNumber"];
          t = await _db.collection("Patients").doc(p).get();
          Appointment a = Appointment();
          a.patientName = t.data()["firstName"] + " " + t.data()["lastName"];
          a.aDateS = doc[i].data()["Date"];
          a.patientNumber = doc[i].data()["PatientNumber"];
          a.reason = doc[i].data()["Reason"];
          a.package = doc[i].data()["Package"];
          a.appointmentType = doc[i].data()["AppointmentType"];
          appointments.add(a);
        }
      }
    } catch (e) {
      print("errorE");
      print(e);
    }
    return appointments;
  }

  Future getUpcomingAppointmentsSpecific(String dE, String pE) async {
    List<Appointment> appointments = List<Appointment>();
    DocumentSnapshot t;
    try {
      QuerySnapshot data = await _db
          .collection("Doctor")
          .doc(dE)
          .collection("Appointment")
          .get();
      var doc = data.docs;
      for (var i = 0; i < doc.length; i++) {
        bool status = doc[i].data()["PaymentStatus"];
        String p = doc[i].data()["PatientNumber"];
        if (status == true && p == pE) {
          t = await _db.collection("Patients").doc(p).get();
          Appointment a = Appointment();
          a.patientName = t.data()["firstName"] + " " + t.data()["lastName"];
          a.aDateS = doc[i].data()["Date"];
          a.patientNumber = doc[i].data()["PatientNumber"];
          a.reason = doc[i].data()["Reason"];
          a.package = doc[i].data()["Package"];
          a.appointmentType = doc[i].data()["AppointmentType"];
          appointments.add(a);
        }
      }
    } catch (e) {
      print("errorE");
      print(e);
    }
    return appointments;
  }

  Future getUpcomingAppointmentsPatient(String phone) async {
    List<Appointment> appointments = List<Appointment>();
    DocumentSnapshot t;
    try {
      QuerySnapshot data = await _db
          .collection("Patients")
          .doc(phone)
          .collection("Appointment")
          .get();
      var doc = data.docs;
      print(doc.length);
      for (var i = 0; i < doc.length; i++) {
        bool status = doc[i].data()["PaymentStatus"];
        if (status == true) {
          String p = doc[i].data()["DoctorNumber"];
          t = await _db.collection("Doctor").doc(p).get();
          Appointment a = Appointment();
          a.doctorName = t.data()["firstName"] + " " + t.data()["lastName"];
          a.aDateS = doc[i].data()["Date"];
          a.doctorNumber = doc[i].data()["DoctorNumber"];
          a.reason = doc[i].data()["Reason"];
          a.package = doc[i].data()["Package"];
          a.timeS = doc[i].data()["Time"];
          a.appointmentType = doc[i].data()["AppointmentType"];
          appointments.add(a);
        }
      }
    } catch (e) {
      print("errorE");
      print(e);
    }
    return appointments;
  }

  Future getPendingPayments(String phone) async {
    List<Appointment> appointments = List<Appointment>();
    DocumentSnapshot t;
    try {
      QuerySnapshot data = await _db
          .collection("Patients")
          .doc(phone)
          .collection("Appointment")
          .get();
      var doc = data.docs;
      for (var i = 0; i < doc.length; i++) {
        bool status = doc[i].data()["PaymentStatus"];
        if (status == false) {
          String p = doc[i].data()["DoctorNumber"];
          t = await _db.collection("Doctor").doc(p).get();
          Appointment a = Appointment();
          a.doctorName = t.data()["firstName"] + " " + t.data()["lastName"];
          a.aDateS = doc[i].data()["Date"];
          a.doctorNumber = doc[i].data()["DoctorNumber"];
          a.reason = doc[i].data()["Reason"];
          a.timeS = doc[i].data()["Time"];
          a.package = doc[i].data()["Package"];
          a.paymentAmount = doc[i].data()["PaymentAmount"];
          appointments.add(a);
        }
      }
    } catch (e) {
      print("errorE");
      print(e);
    }
    return appointments;
  }

  Future getPastAppointmentsDoctor(String phone) async {
    List<Appointment> appointments = List<Appointment>();
    DocumentSnapshot t;
    try {
      QuerySnapshot data = await _db
          .collection("Doctor")
          .doc(phone)
          .collection("CompletedAppointment")
          .get();
      var doc = data.docs;
      for (var i = 0; i < doc.length; i++) {
        String p = doc[i].data()["PatientNumber"];
        t = await _db.collection("Patients").doc(p).get();
        Appointment a = Appointment();
        a.patientName = t.data()["firstName"] + " " + t.data()["lastName"];
        a.reason = doc[i].data()["Reason"];
        a.package = doc[i].data()["Package"];
        a.aDateS = doc[i].data()["Date"];
        a.timeS = doc[i].data()["Time"].toString();
        a.notes = doc[i].data()["Notes"];
        a.appointmentType = doc[i].data()["AppointmentType"];
        appointments.add(a);
      }
    } catch (e) {
      print(e);
    }
    return appointments;
  }

  Future getPastAppointmentsSpecific(String dE, String pE) async {
    List<Appointment> appointments = List<Appointment>();
    DocumentSnapshot t;
    try {
      QuerySnapshot data = await _db
          .collection("Doctor")
          .doc(dE)
          .collection("CompletedAppointment")
          .get();
      var doc = data.docs;
      for (var i = 0; i < doc.length; i++) {
        String p = doc[i].data()["PatientNumber"];
        if (p == pE) {
          t = await _db.collection("Patients").doc(p).get();
          Appointment a = Appointment();
          a.patientName = t.data()["firstName"] + " " + t.data()["lastName"];
          a.reason = doc[i].data()["Reason"];
          a.package = doc[i].data()["Package"];
          a.aDateS = doc[i].data()["Date"];
          a.timeS = doc[i].data()["Time"].toString();
          a.notes = doc[i].data()["Notes"];
          a.appointmentType = doc[i].data()["AppointmentType"];
          appointments.add(a);
        }
      }
    } catch (e) {
      print(e);
    }
    return appointments;
  }

  Future getPastAppointmentsPatient(String phone) async {
    List<Appointment> appointments = List<Appointment>();
    DocumentSnapshot t;
    try {
      print("Getting past appointments");
      QuerySnapshot data = await _db
          .collection("Patients")
          .doc(phone)
          .collection("CompletedAppointment")
          .get();
      var doc = data.docs;
      for (var i = 0; i < doc.length; i++) {
        String p = doc[i].data()["DoctorNumber"];
        t = await _db.collection("Doctor").doc(p).get();
        Appointment a = Appointment();
        a.doctorName = t.data()["firstName"] + " " + t.data()["lastName"];
        a.reason = doc[i].data()["Reason"];
        a.package = doc[i].data()["Package"];
        a.aDateS = doc[i].data()["Date"];
        a.timeS = doc[i].data()["Time"].toString();
        a.notes = doc[i].data()["Notes"];
        a.appointmentType = doc[i].data()["AppointmentType"];
        appointments.add(a);
      }
    } catch (e) {
      print(e);
    }
    return appointments;
  }

  Future rejectAppointment(String dN, String pN, String date) async {
    print("Rejecting Appointment");
    try {
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("AppointmentRequests")
          .doc(date)
          .delete();
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("AppointmentRequests")
          .doc(date)
          .delete();
      return true;
    } catch (e) {
      print(e);
    }
    return;
  }

  Future addAppointmentPatient(String dN, String pN, Appointment a) async {
    try {
      DocumentSnapshot t = await _db.collection("Doctor").doc(dN).get();
      if (a.package == "First time") {
        a.paymentAmount = t.data()["consultationFee"];
      } else {
        a.paymentAmount = t.data()["followUpFee"];
      }
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("AppointmentRequests")
          .doc(a.aDate.toString())
          .set({
        "DoctorNumber": a.doctorNumber,
        "Reason": a.reason,
        "Package": a.package,
        "Date": a.aDate.toString(),
        "PaymentStatus": false,
        "PaymentAmount": a.paymentAmount,
        "AvailableTime": a.availableTime,
        "UnavilableTime": a.unavailableTime,
        "AppointmentType": a.appointmentType,
      });
    } catch (e) {
      print(e);
      return false;
    }
    try {
      DocumentSnapshot t = await _db.collection("Doctor").doc(dN).get();
      if (a.package == "First time") {
        a.paymentAmount = t.data()["consultationFee"];
      } else {
        a.paymentAmount = t.data()["followUpFee"];
      }
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("AppointmentRequests")
          .doc(a.aDate.toString())
          .set({
        "PatientNumber": a.patientNumber,
        "Reason": a.reason,
        "Package": a.package,
        "Date": a.aDate.toString(),
        "PaymentStatus": false,
        "PaymentAmount": a.paymentAmount,
        "AvailableTime": a.availableTime,
        "UnavilableTime": a.unavailableTime,
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future confirmAppointment(String dN, String pN, Appointment a) async {
    print("Confirming Appointment");
    try {
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("Appointment")
          .doc(a.aDateS)
          .set({
        "PatientNumber": a.patientNumber,
        "Reason": a.reason,
        "Package": a.package,
        "Date": a.aDateS,
        "Time": a.time.toString(),
        "PaymentAmount": a.paymentAmount,
        "PaymentStatus": a.paymentStatus,
        "AppointmentType": a.appointmentType,
      });
    } catch (e) {
      print(e);
      return false;
    }
    try {
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("Appointment")
          .doc(a.aDateS)
          .set({
        "DoctorNumber": a.doctorNumber,
        "Reason": a.reason,
        "Package": a.package,
        "Date": a.aDateS,
        "Time": a.time.toString(),
        "PaymentAmount": a.paymentAmount,
        "PaymentStatus": a.paymentStatus,
      });
    } catch (e) {
      print(e);
      return false;
    }
    try {
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("AppointmentRequests")
          .doc(a.aDateS)
          .delete();
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("AppointmentRequests")
          .doc(a.aDateS)
          .delete();
      return true;
    } catch (e) {
      print(e);
    }
  }

  Future completeAppointment(String dN, String pN, Appointment a) async {
    try {
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("CompletedAppointment")
          .doc(a.aDateS)
          .set({
        "PatientNumber": a.patientNumber,
        "Reason": a.reason,
        "Package": a.package,
        "Date": a.aDateS,
        "Time": a.time.toString(),
        "Notes": a.notes,
        "AppointmentType": a.appointmentType,
      });
    } catch (e) {
      print(e);
      return false;
    }
    try {
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("CompletedAppointment")
          .doc(a.aDateS)
          .set({
        "DoctorNumber": a.doctorNumber,
        "Reason": a.reason,
        "Package": a.package,
        "Date": a.aDateS,
        "Time": a.time.toString(),
        "Notes": a.notes
      });
    } catch (e) {
      print(e);
      return false;
    }
    try {
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("Appointment")
          .doc(a.aDateS)
          .delete();
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("Appointment")
          .doc(a.aDateS)
          .delete();
      return true;
    } catch (e) {
      print(e);
    }
  }

  Future confirmPayment(String dN, String pN, Appointment a) async {
    try {
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("Appointment")
          .doc(a.aDateS)
          .update({"PaymentStatus": true, "PaymentID": a.paymentID});
    } catch (e) {
      print(e);
    }
    try {
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("Appointment")
          .doc(a.aDateS)
          .update({"PaymentStatus": true, "PaymentID": a.paymentID});
    } catch (e) {
      print(e);
    }
  }

  Future createTransaction(String dN, String pN, Appointment a) async {
    try {
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("Transactions")
          .doc(pN)
          .set({
        "PaymentID": a.paymentID,
        "PatientNumber": pN,
        "Amount": a.paymentAmount
      });
    } catch (e) {
      print(e);
    }
    try {
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("Transactions")
          .doc(dN)
          .set({
        "PaymentID": a.paymentID,
        "DoctorNumber": dN,
        "Amount": a.paymentAmount
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addOrder(String phone, Orders o) async {
    bool rt = false;
    try {
      await _db
          .collection("Orders")
          .doc(Timestamp.now().toDate().toString())
          .set({
        "Date": Timestamp.now().toDate().toString(),
        "User ID": o.email,
        "Product": o.product,
        "Quantity": o.qty,
        "Name": o.name,
        "Number": o.number,
        "Address Line 1": o.addressLine1,
        "Address Line 2": o.addressLine2,
        "Landmark": o.landmark,
        "Pin-Code": o.pinCode,
        "City": o.city,
        "State": o.state,
        "DeliveryType": o.deliveryType,
        "Price": o.price,
        "PaymentID": o.paymentID,
        "Payment Mode": o.paymentMode,
      });
      rt = true;
    } catch (e) {
      print(e.message);
    }
    return rt;
  }

  // Future getLink(String phone) async {
  //   String link;
  //   Patient p = Patient();
  //   try{
  //     var document = await _db.collection("Patients").doc(phone).collection("otherReports").get();
  //
  //     if(document.docs.isNotEmpty){
  //         var data = document.docs[0].data();
  //         if(data!=null){
  //           p.link = data["link"];
  //           link = p.link.toString();
  //           print("in data link");
  //           print(link);
  //           return link;
  //         }
  //
  //       }
  //
  //   }catch(e){
  //     print(e);
  //   }
  // }

// Future<String> deleteUser(String verificationID,String code)async{
//   try{
//     User _user = _auth.currentUser;
//     print("User Deleted");
//     //AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: null, smsCode: null);
//     AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: code);
//      UserCredential result = await _user.reauthenticateWithCredential(credential);
//      await result.user.delete();
//       print("User deleted finaly");
//   }catch(e){
//     print("Error: Delete");
//     print(e);
//   }
// }

//    Future getCount() async {}
  getNotify(String phone) {}
//    Future storeProfilePicture() async {}
/////////////////////////////////////////////////////////////////
}
