import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar {
  BottomNavigationBar _bottomNavigationBar = BottomNavigationBar(
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
    currentIndex: 1,
    //onTap: (),
  );
}
