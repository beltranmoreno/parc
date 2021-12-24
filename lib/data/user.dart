import 'dart:core';

class UserFire {
  String userID;
  String email;
  String phoneNumber;
  String firstName;
  String lastName;
  bool valet;

  UserFire(
      {required this.userID,
      required this.email,
      required this.phoneNumber,
      required this.firstName,
      required this.lastName,
      required this.valet});
}
