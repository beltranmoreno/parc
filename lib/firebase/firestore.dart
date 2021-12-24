import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parc/data/car.dart';
import 'package:parc/data/user.dart';

class FireStore {
  //final String uid = FirebaseAuth.instance.currentUser!.uid;
  final String uid;
  FireStore({required this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser({required UserFire user}) async {
    return userCollection.doc(uid).set({
      'firstName': user.firstName,
      'lastName': user.lastName,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'valet': user.valet,
      'userID': uid,
    });
  }

  Stream<QuerySnapshot> get userName {
    return userCollection.snapshots();
  }

  Future addCar({required Car car}) async {
    final CollectionReference carCollection =
        userCollection.doc(uid).collection('cars');
    return carCollection
        .doc()
        .set({'carName': car.carName, 'license': car.license});
  }

  bool locExists = false;

  bool locationExists({required String location}) {
    FirebaseFirestore.instance
        .collection('locations')
        .doc(location)
        .get()
        .then((value) => locExists = value.exists);
    if (locExists) {
      return true;
    } else {
      return false;
    }
  }
}
