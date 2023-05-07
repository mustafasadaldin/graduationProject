
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Admin/HomePage.dart';
import 'package:flutter_application_2/Admin/SignupTrainer.dart';
import 'package:flutter_application_2/Admin/UploadProduct.dart';
import 'package:page_transition/page_transition.dart';


class AddNew extends StatefulWidget {
  const AddNew({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AddNew>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Signup_Trainer(),
    EditStore(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(
          index); // Add this line to animate the tab controller to the selected index
      print(_selectedIndex);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);

    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 105, 202),
        shadowColor: Color(0xff81B2F5),
        title: Text('Add New'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                child: HomePage(),
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
              text: 'New Trainer',
            ),
            Tab(
              text: 'New Product',
            ),
          ],
          controller: _tabController,
          // Use the tab controller initialized in the initState method
          onTap: _onItemTapped,
        ),
      ),
      body: TabBarView(
        children: _pages,
        controller: _tabController,
        // Use the tab controller initialized in the initState method
      ),
    );
  }
}
