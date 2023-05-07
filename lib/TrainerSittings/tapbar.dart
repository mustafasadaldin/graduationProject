import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/TrainerSittings/Settings_Page.dart';
import 'package:flutter_application_2/TrainerSittings/bottomBarTrainer.dart';
import 'package:page_transition/page_transition.dart';

import '../settings/Profile.dart';
import 'Edit_Profile.dart';
import 'HomePage.dart';
import 'MyClasses.dart';
import 'Profile.dart';
import 'SearchListUser.dart';
import 'Today.dart';
import 'TodayCompleted.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Tabbar> {

int _selectedIndex = 0;

  final List<Widget> _pages = [
     HomePage_trianer(),
     SearchListUser(),
     Settings_Page(),
     ProfileTrainer(),
  ];  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          
          backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor: Color(0xff81B2F5),
          title: Text('My classes'),
          leading: IconButton(
          onPressed: () {
           Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: bottom_barTrainer(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
          },
          icon: Icon(Icons.arrow_back),
        ),
        
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            tabs: [
            
              Tab(
                
                text: 'All',
              ),
              Tab(
                text: 'Completed',
              ),
              Tab(
                text: 'Today',
              ),
              
            ],
          ),
        ),
        body: TabBarView(
          children: [MyClasses(),
    TodayCompleted(),
     Today(),
   ],
        ),

    
      ),
    );
  }
}
