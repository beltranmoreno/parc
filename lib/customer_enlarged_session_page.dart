import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parc/data/data_objects.dart';
import 'package:parc/user_checkout_page.dart';

class UserSessionPage extends StatefulWidget {
  const UserSessionPage(
      {Key? key,
      required this.buildContext,
      required this.sessionTime,
      required this.location,
      required this.carName,
      required this.license})
      : super(key: key);

  final BuildContext buildContext;
  final String sessionTime;
  final String location;
  final String carName;
  final String license;
  @override
  _UserSessionPageState createState() => _UserSessionPageState();
}

class _UserSessionPageState extends State<UserSessionPage> {
  String estimatePrice = "4.50";
  String sectionOfDay = "PM";
  String checkInTime = "12:34";
  String sessionID = '11143';

  Widget getInfoTile({required String type}) {
    if (type == "location") {
      return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          height: 140,
          width: 160,
          //padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFFFDF4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 40,
              ),
              Column(
                children: [
                  Text(
                    widget.location,
                    style: TextStyle(fontSize: 24, fontFamily: "Open Sans"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Miami Beach",
                    style: TextStyle(fontSize: 12, fontFamily: "Open Sans"),
                  )
                ],
              ),
            ],
          ));
    } else if (type == "time") {
      return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          height: 140,
          width: 160,
          //padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFFFDF4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                CupertinoIcons.clock,
                size: 40,
              ),
              Column(
                children: [
                  Text(
                    widget.sessionTime,
                    style: TextStyle(fontSize: 40, fontFamily: "Open Sans"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          ));
    } else if (type == "checkin") {
      return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          //padding: EdgeInsets.all(10),
          height: 86,
          width: 160,
          //padding: EdgeInsets.all(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFFFDF4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    checkInTime,
                    style: TextStyle(fontSize: 36, fontFamily: "Open Sans"),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    sectionOfDay,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              Text(
                "Check In",
                style: TextStyle(fontSize: 12, fontFamily: "Open Sans"),
              )
            ],
          ));
    } else if (type == "estimate") {
      return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          //padding: EdgeInsets.all(10),
          height: 86,
          width: 160,
          //padding: EdgeInsets.all(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xffFFFDF4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("\$$estimatePrice", style: TextStyle(fontSize: 36)),
              Text("Estimate", style: TextStyle(fontSize: 12))
            ],
          ));
    } else {
      return Column(
        children: [Text("Hello")],
      );
    }
  }

  Widget ValetDriver({
    required ValetPersonInfo valet,
  }) {
    return Container(
      // alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      //width: 375,
      //height: 72,
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
          color: Color(0xffFFFDF4), borderRadius: BorderRadius.circular(16)),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              /*Container(
                    width: 20,
                    //height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xdddddd),
                    ),
                  ),*/
              Icon(
                CupertinoIcons.person,
                size: 32,
              ),
              SizedBox(width: 20),
              Text(
                valet.name,
                style: TextStyle(fontSize: 16, color: Color(0xff294B56)),
              )
            ],
          ),
          Padding(padding: EdgeInsets.fromLTRB(40, 10, 40, 0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff294B56)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent)),
                  child: Icon(CupertinoIcons.chat_bubble),
                  onPressed: () {
                    showiOSMessageAlert(
                        title: "Have any questions?",
                        message: "Message ${valet.name}",
                        cancel: "Cancel",
                        action: "Message");
                  },
                ),
              ),
              //SizedBox(width: 10),
              SizedBox(
                width: 48,
                height: 48,
                child: TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff294B56)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent)),
                  child: Icon(CupertinoIcons.phone),
                  onPressed: () {
                    showiOSModalPopup(
                        name: valet.name, phoneNumber: valet.phoneNumber);
                  },
                ),
              ),
              Padding(padding: EdgeInsets.all(5))
            ],
          )
        ],
      ),
    );
  }

  void showiOSModalPopup({required String name, required String phoneNumber}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        //title: const Text('Title'),
        message: Text("Call $name?"),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(phoneNumber),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void showiOSMessageAlert(
      {required String title,
      required String message,
      required String cancel,
      required String action}) {
    showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title), // 'Have any questions?'
              content: Text(message), // 'Message $name'
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  child: Text(cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text(action),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserCheckoutPage(
                                  sessionID: sessionID,
                                )));
                  },
                )
              ],
            ));
  }

  Widget valetDriverContainer(
      {required String name, required String image, required String label}) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(height: 20, width: 10),
              Text("Valet"),
            ],
          ),
          ValetDriver(
            valet: ValetPersonInfo(name: "Andy F.", phoneNumber: "3054327777"),
          ),
          //Text(image)
        ],
      ),
    );
  }

  Widget checkOutButton() {
    return Container(
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
      width: 360,
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
          "checkout",
          style: TextStyle(
            color: Color(0xffE8C0B5),
            fontSize: 24,
          ),
        ),
        onPressed: () {
          showiOSMessageAlert(
              title: "Proceed to checkout?",
              message: "Tap confirm to proceed.",
              cancel: "Cancel",
              action: "Confirm");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F4E9),
      appBar: AppBar(
        title: Text("Session #$sessionID"),
        backgroundColor: Color(0xffF7F4E9),
        foregroundColor: Color(0xff294B56),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    SizedBox(
                      height: 40,
                    ),
                    Icon(
                      CupertinoIcons.car_detailed,
                      size: 56,
                    ),
                    Text(
                      widget.carName,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Text(
                      widget.license,
                      style: TextStyle(fontSize: 16, color: Color(0xff66867B)),
                    )
                  ])
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getInfoTile(type: "location"),
                  getInfoTile(type: "time")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getInfoTile(type: "checkin"),
                  getInfoTile(type: "estimate")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  valetDriverContainer(
                      name: "Andy F.", image: "0", label: "Valet")
                ],
              ),
              checkOutButton(),
            ],
          ),
        ]),
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffFFFDF4),
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.location_solid), label: "Locations"),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car_rounded), label: "Session"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), label: "Profile")
        ],
        selectedItemColor: Color(0xff66867B),
        unselectedItemColor: Color(0xffE8C0B5),
        iconSize: 32,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        currentIndex: 1,
        //  onTap: (),
      ),*/
    );
  }
}
