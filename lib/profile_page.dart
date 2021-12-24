import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parc/add_car_page.dart';
import 'package:parc/theme/custom_theme.dart';

import 'login_signup.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key, required this.buildContext})
      : super(key: key);

  final BuildContext buildContext;

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Widget greetingContainer(
      {required String name,
      required String memberStatus,
      required String image}) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(12),
      alignment: Alignment.center,
      /*decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xff66867B),
      ),*/
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Hello, $name.",
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Mate',
                        color: Color(0xff294B56)),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(width: 3),
                  Text(
                    memberStatus,
                    style: TextStyle(fontSize: 12, color: Color(0xff294B56)),
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.person,
                size: 40,
              ),
              SizedBox(width: 40)
            ],
          )
        ],
      ),
    );
  }

  Widget userCarsContainer() {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('cars')
            .doc('1')
            .snapshots(),
        builder: (context, snapshot) {
          var userDocument = snapshot.data as DocumentSnapshot;
          return Container(
            margin: EdgeInsets.all(20),
            /*decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xffFFFfdd),
      ),*/
            //height: 250,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              "My Cars",
                              style: TextStyle(fontSize: 24),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            icon: Icon(CupertinoIcons.add),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddCar(
                                            buildContext: context,
                                          )));
                            }),
                        SizedBox(
                          width: 60,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                userCarCard(
                    name: userDocument['carName'],
                    license: userDocument['license'],
                    image: "0"),
              ],
            ),
          );
        });
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
              margin: EdgeInsets.all(20),
              child: Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  "My Cars",
                                  style: TextStyle(fontSize: 24),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                icon: Icon(CupertinoIcons.add),
                                iconSize: 24,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddCar(
                                                buildContext: context,
                                              )));
                                }),
                            SizedBox(
                              width: 60,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
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

  Widget userAccountMenu() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Account",
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xffFFFDF4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Payment Methods"),
                    Icon(CupertinoIcons.right_chevron)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  AppBar appBar(String? name) {
    return AppBar(
      backgroundColor: Color(0xffF7F4E9),
      automaticallyImplyLeading: false,
      elevation: 0.0,
      //backgroundColor: myTheme!.getBGColor(),Text("Hello"),
      centerTitle: false,
      leadingWidth: 15,
      title: Text(
        " Hello, $name",
        style: const TextStyle(
          fontSize: 32,
          color: Color(0xff294B56),
          fontFamily: 'Mate',
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: GestureDetector(
              onTap: () {},
              child: Icon(CupertinoIcons.person,
                  size: 42, color: Color(0xff294B56))),
        )
      ],
    );
  }

  Widget destroyButton(
      {required String type, required Color fore, required Color back}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                (states) => TextStyle(fontSize: 24, fontFamily: 'Montserrat')),
            padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                (states) => EdgeInsets.all(20)),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => fore), // Color(0xffE8C0B5)
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => back), // Color(0xff294B56)
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20));
            }),
          ),
          onPressed: () async {
            if (type == 'sign out') {
              await FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginSignUp()));
            } else if (type == 'delete account') {
              String userID = FirebaseAuth.instance.currentUser!.uid;
              var docUser = FirebaseFirestore.instance
                  .collection('users')
                  .doc(userID)
                  .delete();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginSignUp()));
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                type,
                style: CustomTheme().mainFont,
              ),
            ],
          )),
    );
  }

  Future<void> _getUserName() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc((FirebaseAuth.instance.currentUser!.uid))
        .get()
        .then((value) {
      setState(() {});
    });
  }

  void initState() {
    super.initState();
    _getUserName();
  }

  final firestore = FirebaseFirestore.instance; //
  FirebaseAuth auth = FirebaseAuth
      .instance; //recommend declaring a reference outside the methods

  @override
  Widget build(BuildContext context) {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .snapshots(),
        builder: (context, snapshot) {
          var userDocument = snapshot.data as DocumentSnapshot;
          return Scaffold(
            backgroundColor: Color(0xffF7F4E9),
            appBar: appBar(userDocument['firstName']),
            body: SafeArea(
              child: ListView(children: [
                Padding(padding: EdgeInsets.only(top: 10)),
                //userCarsContainer(),
                userCarsFuture(),
                userAccountMenu(),
                destroyButton(
                    type: 'sign out',
                    fore: Color(0xffE8C0B5),
                    back: Color(0xff294B56)),
                destroyButton(
                    type: 'delete account',
                    fore: Color(0xff294B56),
                    back: Color(0xffE8C0B5))
              ]),
            ),
          );
        });
  }
}
