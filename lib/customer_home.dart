import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parc/customer_sessions_page.dart';
import 'package:parc/profile_page.dart';
import 'package:parc/valet_locations_page.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 100), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(controller: pageController, children: [
          UserValetLocation(buildContext: context),
          CustomerSessionPage(context: context),
          UserProfilePage(buildContext: context),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xffF7F4E9),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.location),
                activeIcon: Icon(CupertinoIcons.location_solid),
                label: "Locations"),
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_car_outlined),
                activeIcon: Icon(Icons.directions_car_filled_rounded),
                label: "Session"),
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
          currentIndex: _selectedIndex,
          onTap: onTapped,
        ));
  }
}
