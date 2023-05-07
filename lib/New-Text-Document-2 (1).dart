import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:vs_scrollbar/vs_scrollbar.dart';

import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';

class Booking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookingState();
  }
}

class BookingState extends State<Booking> {
  List<String> labels = ["Booking", "Appointment"];
  int currentIndex = 0;
  List teacher = [
    "Ehab Sarrawi",
    "Mahmoud Saddouq",
    "Ahmad Saddouq",
    "Khaled Saddouq",
    "Mohammod Saddouq",
  ];
  bool _verticalList = false;
  var instrument = 0;
  ScrollController _scrollController = ScrollController();
  DateTime _selectedDate = DateTime.now();
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: InkWell(
                      child: Image.asset(
                        'images/icons-menu.png',
                        height: 30,
                      ),
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 15, bottom: 5),
                    child: Text(
                      'Booking',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
              ),
              currentIndex == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 18, bottom: 8),
                          child: Text(
                            'Choose a Date',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.grey[700]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 231, 241, 241),
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Text(
                            'Choose an instrument',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.grey[700]),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 650,
                          child: VsScrollbar(
                            controller: _scrollController,
                            showTrackOnHover: true,
                            isAlwaysShown: false,
                            scrollbarFadeDuration: Duration(milliseconds: 500),
                            scrollbarTimeToFade: Duration(milliseconds: 800),
                            style: VsScrollbarStyle(
                              hoverThickness: 10.0,
                              radius: Radius.circular(10),
                              thickness: 5.0,
                              color: Colors.purple.shade900,
                            ),
                            child: ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: _verticalList
                                    ? Axis.vertical
                                    : Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int index) {
                                  Color? color = Colors.pink[600];
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        instrument = index;
                                      });
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Text(
                                              'adel halawa',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: instrument == index
                                                    ? Colors.white
                                                    : Colors.black,
                                                height: 1,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              child: AdvancedAvatar(
                                                size: 40,
                                                image: AssetImage(
                                                    'images/Logo.png'),
                                                foregroundDecoration:
                                                    BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "${teacher[index]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: instrument == index
                                                    ? Colors.white
                                                    : Colors.black,
                                                height: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                300,
                                        decoration: BoxDecoration(
                                            color: instrument == index
                                                ? color
                                                : Color.fromARGB(
                                                    255, 231, 241, 241),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 20)),
                                  );
                                }),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 15, bottom: 50),
                          child: ElevatedButton(
                            child: Text("Booking Now"),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink[600],
                              onPrimary: Colors.white,
                              minimumSize: const Size(150, 40),
                              textStyle: TextStyle(
                                fontSize: 18,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 110),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 450,
                      child: ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        itemCount: 3,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(indent: 16),
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          width: 283,
                          height: 160,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 231, 241, 241),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 30,
                                right: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 80,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.pink[600],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          "9-10 am",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        width: 100,
                                        height: 25,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.pink[600],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          "28-3" + "  " + "Mon",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${teacher[index]}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'mustafa',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 71, 65, 65),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 15,
                                child: SizedBox(
                                  width: 80,
                                  height: 110,
                                  child: Hero(
                                    tag: "${teacher[index]}",
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 40,
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                            AssetImage('imagess/sport.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 5,
                                  right: 15,
                                  child: InkWell(
                                    //onTap: () => showFullScreenMenu(context),
                                    child: Image.asset(
                                        "images/icons-meatball.png",
                                        height: 30),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
