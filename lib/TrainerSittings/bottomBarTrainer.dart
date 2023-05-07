import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/TrainerSittings/SearchListUser.dart';
import 'package:flutter_application_2/TrainerSittings/SearchListUserBar.dart';
import 'package:flutter_application_2/settings/Settings_Page.dart';
import 'package:flutter_application_2/settings/store.dart';
import 'package:page_transition/page_transition.dart';

import 'HomePage.dart';
import 'Profile.dart';

class bottom_barTrainer extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<bottom_barTrainer> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage_trianer(),
    SearchTabbarUser(),
    Storee(),
    ProfileTrainer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.shopping_cart, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blue,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
