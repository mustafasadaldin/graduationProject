
import 'package:flutter/material.dart';
import 'package:flutter_application_2/TrainerSittings/SearchListUser.dart';
import 'package:flutter_application_2/TrainerSittings/bottomBarTrainer.dart';
import 'package:flutter_application_2/settings/Search.dart';
import 'package:flutter_application_2/settings/bottomBar.dart';
import 'package:page_transition/page_transition.dart';
import '../global.dart';

class SearchTabbarUser extends StatefulWidget {
  const SearchTabbarUser({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SearchTabbarUser>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  List cities = ['All', 'Nablus', 'Jenen', 'Ramallah'];
  final List<Widget> _pages = [
    SearchListUser(),
    SearchListUser(),
    SearchListUser(),
    SearchListUser(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(
          index);
          global.selectedCityT = cities.elementAt(_selectedIndex);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);

    _tabController.addListener(_handleTabSelection);
    global.selectedCityT="All";
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
        title: Text('Search'),
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
              text: 'Nablus',
            ),
            Tab(
              text: 'Jenen',
            ),
            Tab(
              text: 'Ramallah',
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
