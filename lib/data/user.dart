import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parc/data/car.dart';

class User {
  String userID;
  String email;
  String firstName;
  String lastName;
  Timestamp accountCreated;
  Car car;

  User(
      {required this.userID,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.accountCreated,
      required this.car});

  User.fromDocumentSnapshot({required DocumentSnapshot doc}) {
    userID = doc.get(userID);
    email = doc.data('email');
    accountCreated = doc.data['accountCreated'];
    firstName = doc.data['firstName'];
    lastName = doc.data['lastName'];
    car = doc.data['car'];
  }
}
