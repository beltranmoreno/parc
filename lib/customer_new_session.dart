import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parc/assets/button.dart';
import 'package:parc/firebase/firestore.dart';
import 'package:parc/theme/colors.dart';

class NewSessionPage extends StatefulWidget {
  const NewSessionPage({Key? key, required this.buildContext})
      : super(key: key);

  final BuildContext buildContext;

  // UserSession userSession = UserSession(name: name, sessionID: sessionID)

  @override
  _NewSessionPageState createState() => _NewSessionPageState();
}

class _NewSessionPageState extends State<NewSessionPage> {
  final _locationController = TextEditingController();

  Widget CTAButton() {
    return Container(
      height: 64,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xff294B56)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              //side: BorderSide(color: Colors.red)
            ))),
        child: Text(
          "begin",
          style: TextStyle(
            color: Color(0xffE8C0B5),
            fontSize: 24,
          ),
        ),
        onPressed: () {
          final userID = FirebaseAuth.instance.currentUser!.uid;
          bool exists = false;
          exists = FireStore(uid: userID)
              .locationExists(location: _locationController.text);
          if (exists == true) {
            AlertDialog(title: Text("Exists"));
          } else {
            AlertDialog(title: Text("Does not exist"));
          }
          /*showiOSMessageAlert(
              title: "Proceed to checkout?",
              message: "Tap confirm to proceed.",
              cancel: "Cancel",
              action: "Confirm");*/
        },
      ),
    );
  }

  Widget CTAButtonFuture(String? location) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('locations')
          .doc(location)
          .get(),
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.data.exists) {
          return Container(
              height: 64,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff294B56)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      //side: BorderSide(color: Colors.red)
                    ))),
                child: Text(
                  "begin",
                  style: TextStyle(
                    color: Color(0xffE8C0B5),
                    fontSize: 24,
                  ),
                ),
                onPressed: () {
                  print("Not found");
                  popUpMessage("No location found");
                },
              ));
        } else {
          return Container(
              height: 64,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xff294B56)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      //side: BorderSide(color: Colors.red)
                    ))),
                child: Text(
                  "begin",
                  style: TextStyle(
                    color: Color(0xffE8C0B5),
                    fontSize: 24,
                  ),
                ),
                onPressed: () {
                  print("Found");
                  popUpMessage("FOUND");
                },
              ));
        }
      },
    );
  }

  Future getCarData({required String uid}) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cars')
        .get();
    return qs.docs;
  }

  Widget userCarsFuture() {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder(
        future: getCarData(uid: userID),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              //margin: EdgeInsets.all(20),
              child: Expanded(
                child: Column(
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return userCarCard(
                            name: snapshot.data[index]['carName'],
                            license: snapshot.data[index]['license'],
                            image: "0");
                      },
                      itemCount: snapshot.data!.length,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget userCarCard(
      {required String name, required String license, required String image}) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xffFFFDF4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Column(
                    children: [Icon(CupertinoIcons.car_detailed)],
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(license)
                    ],
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(CupertinoIcons.chevron_forward)],
          )
        ],
      ),
    );
  }

  Widget popUpMessage(String message) {
    return AlertDialog(
      title: Text(message),
    );
  }

  @override
  Widget build(BuildContext context) {
    var loc = '11111';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xffF7F4E9),
        foregroundColor: Color(0xff294B56),
        elevation: 0.0,
        title: Text("New Session"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Done",
              style: TextStyle(color: Color(0xff294B56), fontSize: 16),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.all(20),
        child: ListView(children: [
          ListTile(
            title: Text("Enter location number:"),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _locationController,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 5,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Location",
                suffixIcon: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              popUpMessage("Check for PARC location number."));
                    },
                    icon: Icon(CupertinoIcons.info))),
            validator: (value) {
              loc = _locationController.text;
              if (value == null || value.isEmpty)
                return "Please enter only numbers.";
              return null;
            },
          ),
          ListTile(
            title: Text("Choose a car:"),
          ),
          userCarsFuture(),
          Padding(padding: EdgeInsets.only(top: 30)),
          CTAButtonFuture(loc),
          PrimaryButton(
              buildContext: context, title: "nice", fore: pink, back: darkGreen)
        ]),
      )),
    );
  }
}
