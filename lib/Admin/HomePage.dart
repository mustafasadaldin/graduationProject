import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_2/Admin/AddNew.dart';
import 'package:flutter_application_2/Admin/SearchListProducts.dart';
import 'package:flutter_application_2/Admin/SearchListTrainers.dart';
import 'package:flutter_application_2/Admin/TabBarTrainers.dart';
import 'package:flutter_application_2/Admin/UsersTabBar.dart';
import 'package:flutter_application_2/settings/MethodsChat.dart';
import 'package:page_transition/page_transition.dart';

import 'NavBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
          title: Text('Admin Page'),
        ),
        body: Container(
          padding: EdgeInsets.all(30.0),
          child: GridView.count(crossAxisCount: 2, children: <Widget>[
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      alignment: Alignment.topCenter,
                      child: AddNew(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                },
                splashColor: Colors.blue,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_box_outlined,
                        size: 100,
                        color: Colors.green,
                      ),
                      Text(
                        "Add New",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      alignment: Alignment.topCenter,
                      child: SearchListProduct(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                },
                splashColor: Colors.blue,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 100,
                        color: Colors.red,
                      ),
                      Text(
                        "Shop",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      alignment: Alignment.topCenter,
                      child: ShowUsers(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                },
                splashColor: Colors.blue,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.blue,
                      ),
                      Text(
                        "Users",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      alignment: Alignment.topCenter,
                      child: ShowTrainers(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                },
                splashColor: Colors.blue,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.sports_gymnastics_outlined,
                        size: 100,
                        color: Colors.yellow,
                      ),
                      Text(
                        "Trainers",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
