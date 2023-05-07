
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Admin/HomePage.dart';
import 'package:flutter_application_2/Admin/SearchListUser.dart';
import 'package:page_transition/page_transition.dart';
import '../global.dart';

class ShowUsers extends StatefulWidget {
  const ShowUsers({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ShowUsers>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
List cities = ['All', 'Nablus', 'Jenen', 'Ramallah'];
  final List<Widget> _pages = [
    SearchListUsers(),
    SearchListUsers(),
    SearchListUsers(),
    SearchListUsers(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(
          index); // Add this line to animate the tab controller to the selected index
       global.selectedCity = cities.elementAt(_selectedIndex);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);

    _tabController.addListener(_handleTabSelection);
    global.selectedCity="All";
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
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 15, 105, 202),
        shadowColor: Color(0xff81B2F5),
        title: Text('Users'),
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
              text: 'All',
            ),
            Tab(
              text: 'Nablus',
            ),
            Tab(
              text: 'Jenen',
            ),
            Tab(
              text: 'Ramalah',
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
