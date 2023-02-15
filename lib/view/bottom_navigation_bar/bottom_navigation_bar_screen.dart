import 'package:flutter/material.dart';

class BottomNavigationBarData {
  static var items = [
    BottomNavigationBarItem(icon: Icon(Icons.home),
        label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.settings),
        label: "Settings"),
    BottomNavigationBarItem(icon: Icon(Icons.person),
        label: "Profile")
  ];

  static List<Widget> widgets = [
    Container(
      child: Center(child: Text("Home")),
    ),
    Container(
      child: Center(child: Text("Settings")),
    ),
    Container(
      child: Center(child: Text("Profile")),
    )
  ];


}
