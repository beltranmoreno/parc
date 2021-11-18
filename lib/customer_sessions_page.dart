import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parc/assets/style.dart';
import 'package:parc/customer_new_session.dart';
import 'package:parc/data/data_objects.dart';
import 'package:parc/profile_page.dart';
import 'package:parc/valet_locations_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customer_enlarged_session_page.dart';

class CustomerSessionPage extends StatefulWidget {
  const CustomerSessionPage({
    Key? key,
    required this.context,
  }) : super(key: key);
  final BuildContext context;

  @override
  _CustomerSessionPageState createState() => _CustomerSessionPageState();
}

class _CustomerSessionPageState extends State<CustomerSessionPage> {
  //Widget session() {}

  MyTheme? myTheme;
  UserSession session_01 = UserSession(name: "John", sessionID: 144232);
  UserSession session_02 = UserSession(name: "Juan", sessionID: 1555555);
  UserSession sessionPre_01 = UserSession(name: "H", sessionID: 1144423);
  UserSession sessionPre_02 = UserSession(name: "J", sessionID: 3333333);

  String timeSinceStart = "2:03";
  int _selectedIndex = 0; // Nav bar index

  @override
  void initState() {
    getNavBarPreference();
    super.initState();
  }

  void setSession(
      {required UserSession session,
      required String checkin,
      required String carName,
      required String license,
      required String placeName,
      required String placeLocation}) {
    session.checkInTime = checkin;
    session.setCarInfo(c_name: carName, c_license: license);
    session.setLocationInfo(c_name: placeName, c_location: placeLocation);
    session.location.name = placeName;
    session.location.expLocation = placeLocation;
  }

  Widget sessionCard(
      {required UserSession session,
      required bool current,
      required String sessionTime,
      required String location,
      required String carName,
      required String license}) {
    setSession(
        session: session,
        checkin: "12:07",
        carName: "Defend",
        license: "HHD 445",
        placeName: "Graziano's",
        placeLocation: "Miami Beach");
    if (current) {
      return Container(
        //padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        height: 176,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xff66867B),
        ),
        child: InkWell(
          /*style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(10)),
          ),*/
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.car_detailed,
                          size: 42,
                          color: Color(0xffFFFDF4),
                        )
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                carName,
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 24,
                                    color: Color(0xffFFFDF4)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 2),
                              Text(
                                license,
                                style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 12,
                                    color: Color(0xffE8C0B5)),
                              )
                            ],
                          )
                        ])
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          sessionTime,
                          style: TextStyle(
                              fontFamily: "Open Sans",
                              fontSize: 56,
                              color: Color(0xffFFFDF4)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          CupertinoIcons.location_solid,
                          color: Color(0xffE8C0B5),
                        ),
                        Text(
                          location,
                          style: TextStyle(
                              fontFamily: "Open Sans",
                              fontSize: 16,
                              color: Color(0xffFFFDF4)),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserSessionPage(
                          buildContext: context,
                          sessionTime: sessionTime,
                          location: location,
                          carName: carName,
                          license: license,
                        )));
          },
        ),
      );
    } else {
      return Container(
        //padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        height: 176,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xff294B56),
        ),
        child: InkWell(
          /*style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(10)),
          ),*/
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.car_detailed,
                          size: 42,
                          color: Color(0xffFFFDF4),
                        )
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                carName,
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 24,
                                    color: Color(0xffFFFDF4)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 2),
                              Text(
                                license,
                                style: TextStyle(
                                    fontFamily: "Open Sans",
                                    fontSize: 12,
                                    color: Color(0xffE8C0B5)),
                              )
                            ],
                          )
                        ])
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          sessionTime,
                          style: TextStyle(
                              fontFamily: "Open Sans",
                              fontSize: 56,
                              color: Color(0xffFFFDF4)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          CupertinoIcons.location_solid,
                          color: Color(0xffE8C0B5),
                        ),
                        Text(
                          location,
                          style: TextStyle(
                              fontFamily: "Open Sans",
                              fontSize: 16,
                              color: Color(0xffFFFDF4)),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserSessionPage(
                          buildContext: context,
                          sessionTime: sessionTime,
                          location: location,
                          carName: carName,
                          license: license,
                        )));
          },
        ),
      );
    }
  }

  void _NavBarNav(int index) {
    if (index == 0) {
      setIndex();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserValetLocation(
                    buildContext: context,
                  )));
    } else if (index == 1) {
      setIndex();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CustomerSessionPage(
                    context: context,
                  )));
    } else if (index == 2) {
      setIndex();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserProfilePage(
                    buildContext: context,
                  )));
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  //   Color(0xff66867B) - semi dark
  //   Color(0xff294B56) - dark

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xffF7F4E9),
        appBar: AppBar(
          bottom: TabBar(
              indicatorWeight: 5,
              indicatorColor: Color(0xff294B56),
              tabs: [
                Tab(
                    child: Text(
                  "Current",
                  style: TextStyle(fontSize: 16, color: Color(0xff66867B)),
                )),
                Tab(
                    child: Text(
                  "Previous",
                  style: TextStyle(fontSize: 16, color: Color(0xff66867B)),
                )),
              ]),
          backgroundColor: Color(0xffF7F4E9),

          automaticallyImplyLeading: false,
          elevation: 0.0,
          //backgroundColor: myTheme!.getBGColor(),Text("Hello"),

          title: Text(
            "Sessions",
            style: TextStyle(fontSize: 32, color: Color(0xff294B56)),
          ),

          centerTitle: false,
          leadingWidth: 15,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewSessionPage(
                                  buildContext: context,
                                )));
                  },
                  child: Icon(CupertinoIcons.add,
                      size: 24, color: Color(0xff294B56))),
            ),
          ],
        ),
        body: TabBarView(children: [
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                sessionCard(
                    session: session_01,
                    current: true,
                    sessionTime: "2:03",
                    location: "Graziano's",
                    carName: "Defender",
                    license: "HDD 657"),
                sessionCard(
                    session: session_02,
                    current: true,
                    sessionTime: "3:27",
                    location: "Hotel Duval",
                    carName: "M4",
                    license: "FHS 897")
              ],
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                sessionCard(
                    session: sessionPre_01,
                    current: false,
                    sessionTime: "2:03",
                    location: "Graziano's",
                    carName: "Defender",
                    license: "HDD 657"),
                sessionCard(
                    session: sessionPre_02,
                    current: false,
                    sessionTime: "3:27",
                    location: "Hotel Duval",
                    carName: "M4",
                    license: "FHS 897")
              ],
            ),
          ),
        ]),
        /*bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xffF7F4E9),
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
          // type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          currentIndex: 1,
          onTap: _NavBarNav,
        ),*/
      ),
    );
  }

  // Shared Preferences for Nav Bar index
  Future<void> saveNavBarPreference(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("index", index);
  }

  Future<void> getNavBarPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getInt("index");
  }

  void setIndex() {
    int index = _selectedIndex;
    saveNavBarPreference(index);
  }
}
