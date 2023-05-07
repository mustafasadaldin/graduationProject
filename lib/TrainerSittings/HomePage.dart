// ignore_for_file: prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_application_2/TrainerSittings/About.dart';
import 'package:flutter_application_2/TrainerSittings/MyUsersProfile.dart';
import 'package:flutter_application_2/TrainerSittings/tapbar.dart';
import 'package:flutter_application_2/global.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/settings/ChatHomeScreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'Edit_Profile.dart';
import 'MyClasses.dart';
import 'Profile.dart';
import 'SearchListUser.dart';
import 'Settings_Page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global.dart';



class HomePage_trianer extends StatefulWidget {
  buildStyles(BuildContext, int index) {}
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<HomePage_trianer> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

late Future allData;

List usersImages=[];
List usersNames=[];
List usersDays=[];
List usersTimes=[];
List tempImages=[];
List tempNames=[];
bool _verticalList = false;
var colors = [
    Color(0xff06CA88),
    Color(0xffEBAD48),
    Color.fromARGB(255, 103, 96, 233),
    Color(0xffFD5A49),
  ];
  var usersCount=0;
  var usersCount2=0;

  int _selectedIndex = 0;

  final List<Widget> _pages = [
     HomePage_trianer(),
     SearchListUser(),
     Settings_Page(),
     ProfileTrainer(),
  ];
@override
  void initState() {
    super.initState();
    allData=getMyUsersInfo();
    checkIfNotify();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
               accountName: Text(global.username.split(" ")[0]+" "+global.username.split(" ")[3], style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: 20),),
                accountEmail: Text(global.email,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: 20)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 15, 105, 202),
                  child: Text(global.email.split("")[0].toUpperCase()),

                  /*child: ClipOval(
                child: Image.asset(
                  "imagess/Mustafa.png",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),*/
                ),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  image: DecorationImage(
                      image: AssetImage('imagess/test.png'),
                      fit: BoxFit.cover),
                ),
              ),
              
              ListTile(
                title: Text(
                  "Personal Detalis",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                ),
                subtitle: Text(
                  "Show my information",
                ),
                leading: Icon(
                  Icons.person,
                  color: Colors.red,
                ),
                onTap: () {
                   Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: ProfileTrainer(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                title: Text(
                  "Chat",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                ),
                subtitle: Text("Contact us"),
                leading: Icon(
                  Icons.chat,
                  color: Colors.green,
                ),
                onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen(global.email)));
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                title: Text(
                  "About",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                ),
                subtitle: Text("Learn more about A&M GYM"),
                leading: Icon(
                  Icons.info_rounded,
                  color: Colors.orange,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => About()));
                },
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
        title: Row(
          children: [
        
            Text('Trainer page', style:TextStyle( color: Colors.white))
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    alignment: Alignment.topCenter,
                    child: Settings_Page(),
                    duration: Duration(milliseconds: 1000),
                  ),
                );
              },
              icon: Icon(Icons.notifications_none)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    alignment: Alignment.topCenter,
                    child: Settings_Page(),
                    duration: Duration(milliseconds: 1000),
                  ),
                );
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body:  Waitforme(),
      
    
    );
  }



Widget Waitforme() {
  
  return FutureBuilder( future: Future.wait([allData]), builder:((context, snapshot)  {
Size size = MediaQuery.of(context).size;
      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
         Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Text(
                  "My subscribers",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            SizedBox(
              height: 180.0, // Set a fixed height for the SizedBox
              child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: MediaQuery.of(context).size.height - 690,
                          child: VsScrollbar(
                            showTrackOnHover: true,
                            isAlwaysShown: false,
                            scrollbarFadeDuration: Duration(milliseconds: 500),
                            scrollbarTimeToFade: Duration(milliseconds: 800),
                            style: VsScrollbarStyle(
                              hoverThickness: 10.0,
                              radius: Radius.circular(10),
                              thickness: 5.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: _verticalList
                                    ? Axis.vertical
                                    : Axis.horizontal,
                                itemCount: usersCount,
                                itemBuilder: (BuildContext context, int index) {
                                  Color? color = colors[index%colors.length];
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        global.userUserName = usersNames.elementAt(index);
                                        Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.leftToRightWithFade,
                                          child: UDetails(),
                                          duration: Duration(milliseconds: 1000),
                                        ),
                                      );
                                      });
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            
                                            SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              child: AdvancedAvatar(
                                                size: 100,
                                                image: "${usersImages[index]}"!=""?MemoryImage(base64Decode("${usersImages[index]}")):AssetImage('imagess/profilePic.png') as ImageProvider,
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
                                              "${usersNames[index].split(" ")[0]+ " " + usersNames[index].split(" ")[3]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color:  Colors.white,
                                                    
                                                height: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                200,
                                        decoration: BoxDecoration(
                                            color:  color,
                                                
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10)),
                                  );
                                }),
                          ),
                        ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8),
            
               
                 
                child:  Row(
                  children: [
                    Text(
                        'My classes',
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),

            SizedBox(width: 230,),
                        InkWell(
                  onTap: () {
        setState(() {
         Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: Tabbar(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
        });
      },
      child: Text(
        'See all',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
                

                  ),
                  ],
                ),
        

                 
               
            ),
            SizedBox(
              height: 2,
            ),
            Expanded(
              child: Container(
                height: size.height * 0.6,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: usersCount2,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: size.width * 0.6,
                          //height: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(5, 5))
                              ]),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Hero(
                                      tag: index.toString(),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: Image(
                                          height: 70.0,
                                          width: 70.0,
                                                image: "${tempImages[index]}"!=""?MemoryImage(base64Decode("${tempImages[index]}")):AssetImage('imagess/profilePic.png') as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${tempNames[index].split(" ")[0] + " " +tempNames[index].split(" ")[3]}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.date_range_outlined),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                            "${usersDays[index]}"
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.access_time_outlined),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              "${usersTimes[index]}",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
            
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: <Widget>[
                              //     TextButton(
                              //       child: const Text('BUY TICKETS'),
                              //       onPressed: () {/* ... */},
                              //     ),
                              //     const SizedBox(width: 8),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      );
   
        
  }));

}


Future getMyUsersInfo() async {

  var body1 = jsonEncode({
  "username": global.trainerUsername,
});


var res= await http.post(Uri.parse(global.globall+"/users/getMyUsersImages"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);


  if(res.statusCode == 200) {
    Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['strImage'];
    var arrayUsers = array.split(",");
   usersCount=arrayUsers.length-1;
    for(int i=0; i<(usersCount); i++) {
      usersImages.add(arrayUsers[i]);
    }

    await getMyUsersName();
    await getMyUsersReservedTimes();
    return await [usersImages];
  }
  else if(res.statusCode == 401) {
    print("not authenticated");
    return null;
  }

  else if(res.statusCode == 400) {
    print('errorImages');
    return null;
  }
}

Future getMyUsersName() async {


  var body1 = jsonEncode({
  "username": global.trainerUsername,
});


var res= await http.post(Uri.parse(global.globall+"/users/getMyUsersUserNames"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);


  if(res.statusCode == 200) {
    Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['strNames'];
    var arrayUsers = array.split(",");
    for(int i=0; i<(arrayUsers.length-1); i++) {
      usersNames.add(arrayUsers[i]);
    }
    return await [usersNames];
  }
  else if(res.statusCode == 401) {
    print("not authenticated");
    return null;
  }

  else if(res.statusCode == 400) {
    print('errorImages');
    return null;
  }

}


Future getMyUsersReservedTimes() async {

var body1 = jsonEncode({
  "username": global.trainerUsername,
});

//strTimes = strTimes + ele.day + ":" + ele.session + ":"+ element.image.toString("base64") + ":"+ element.userName + ","

var res= await http.post(Uri.parse(global.globall+"/users/getMyUsersTimes"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

if(res.statusCode == 200) {
    Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['strTimes'];
    var arrayUsers = array.split(",");
    usersCount2=arrayUsers.length-1;
    global.globalCountForUsers=arrayUsers.length-1;
    if(usersCount2 > 3) {
      usersCount2 =3;
    }
    for(int i=0; i<(arrayUsers.length-1); i++) {
     var temp=arrayUsers[i].split(":");
     usersDays.add(temp[0]);
     usersTimes.add(temp[1]);
     tempImages.add(temp[2]);
     tempNames.add(temp[3]);
    }

    global.images=tempImages;
    global.days=usersDays;
    global.times=usersTimes;
    global.names=tempNames;
    print(usersCount2);
    print(global.globalCountForUsers);
    return await [tempNames];
  }
  else if(res.statusCode == 401) {
    print("not authenticated");
    return null;
  }

  else if(res.statusCode == 400) {
    print('errorImages');
    return null;
  }


}



Future checkIfNotify() async{

var res= await http.get(Uri.parse(global.globall+"/trainers/notify"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  });

  if(res.statusCode == 200) {
     Map<String, dynamic> DB = jsonDecode(res.body);
     if(DB['val']!="N") {

       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.pink,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("${notification.title}"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("${notification.body}")],
                  ),
                ),
              );
            });
      }
    });
        flutterLocalNotificationsPlugin.show(
        0,
        "Imprtant Meassge!",
        "you have a new member "+ DB['val'] + " is regestered",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));

     }

     else if(DB['val'] == "N") {
      print(DB['val']);
     }

  }

  else if(res.statusCode == 400) {
    print('error');
  }

  else if(res.statusCode == 401) {
    print('not authenticated');
  }
}

}