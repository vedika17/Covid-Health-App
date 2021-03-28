import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications {
  final db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User user;

  handleInput(String input, String email) {
    user = auth.currentUser;
    print("handle input gets called");
    print(email);
    db.collection("Doctor").doc(email).collection("notifications").add({
      "message": input,
      "title": email,
      "date": FieldValue.serverTimestamp()
    });
  }
}
