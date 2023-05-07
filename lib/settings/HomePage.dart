// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_application_2/global.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/settings/ChatHomeScreen.dart';
import 'package:flutter_application_2/settings/showProductInfo.dart';
import 'package:flutter_application_2/settings/store.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'About.dart';
import 'Edit_Profile.dart';
import 'Profile.dart';
import 'Search.dart';
import 'Settings_Page.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import '../global.dart';
import 'Subscribtion.dart';
import 'TrainerUserInfo.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
class HomePage_user extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<HomePage_user> {
  TextEditingController _searchController = TextEditingController();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var instrument = 0;
  var trainersCount;
  List trainersImages = [];
  List trainersNames = [];
  List tempTreainersUsernames=[];
  List hNames=[];
  List hImg=[];
  List hPImg=[];
  List hPNames=[];
  bool _verticalList = false;
  bool _showSearchBar = false;
 late Future img;
 late Future trainersUserNames;
 List<String> cities=['All','Nablus','Ramallah','jenen'];
 String city='All';
late Future highliImg;
late Future highlyNames;
late Future highlyPImg;
late Future highlyPNames;
  var colors = [
    Color(0xff06CA88),
    Color(0xffEBAD48),
    Color.fromARGB(255, 103, 96, 233),
    Color(0xffFD5A49),
  ];


  int _selectedIndex = 0;

  final List<Widget> _pages = [
     HomePage_user(),
     SearchList(),
     Settings_Page(),
     Profile(),
  ];

  void initState(){
    super.initState();
    img = getTrainersImages();
    trainersUserNames = getTrainerNames();
    highlyNames=getHighlyNames();
    highliImg=getHighlyImages();
    highlyPNames=getHighlyProductsNames();
    highlyPImg=getHighlyProductsImages();
    checkIfNotify();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        drawer:  Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(global.username.split(" ")[0]+" "+global.username.split(" ")[3], style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: 20),),
                accountEmail: Text(global.email,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: 20)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 15, 105, 202),
                  child: Text(global.email.split("")[0].toUpperCase()),
                ),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  image: DecorationImage(
                      image: AssetImage(
                          'imagess/test.png'),
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
                      child: Profile(),
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
          title: Text('User Page'),
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
             

                icon: Icon(Icons.settings)),

          ],

          
        ),
        
      body: 
      
      SingleChildScrollView(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
            height: 5.0,
          ),


        Padding(
                             padding: const EdgeInsets.all(2.0),
                             child: Text(
                              'Discover our Trainers:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 19.0
                              ),
                                                   ),
                           ),
        
    
                           
         
          Waitforme(),  

          


           Padding(
                             padding: const EdgeInsets.all(2.0),
                             child: Text(
                              'Highly rated trainers:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 19.0
                              ),
                                                   ),
                           ),

                          
                           Waitforme2(),

                            Padding(
                             padding: const EdgeInsets.all(2.0),
                             child: Text(
                              'Top products:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 19.0
                              ),
                                                   ),
                           ),
Waitforme3(),


            Container(
                          padding: EdgeInsets.only(left: 10),
                       
                          child: Row(
                            children: [
                              Text("Do you want to subscribe with us ? ",
                                  style: TextStyle(fontSize: 15)),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type:
                                          PageTransitionType.bottomToTopJoined,
                                      child: Subscribtion(),
                                      childCurrent: HomePage_user(),
                                      duration: Duration(milliseconds: 1000),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Subcribe now !",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ), 

        ],),
      ),

     

        );
  }

Widget Waitforme() {
  
  return FutureBuilder( future: Future.wait([img, trainersUserNames]), builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
         
      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: MediaQuery.of(context).size.height - 650,
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
                                itemCount: trainersCount,
                                itemBuilder: (BuildContext context, int index) {
                                  Color? color = colors[index%colors.length];
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        instrument = index;
                                        global.trainerUsername = tempTreainersUsernames.elementAt(index);
                                        print(global.trainerUsername);
                                        Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.leftToRightWithFade,
                                          child: TrainerUserInfo(),
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
                                                image: "${trainersImages[index]}"!=""?MemoryImage(base64Decode("${trainersImages[index]}")):AssetImage('imagess/profilePic.png') as ImageProvider,
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
                                              "${trainersNames[index]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color:  Colors.black,
                                                    
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
                        );
        
  }));

}















Widget Waitforme2() {
  
  return FutureBuilder( future: Future.wait([highliImg, highlyNames]), builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
         
      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: MediaQuery.of(context).size.height - 650,
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
                                itemCount: hNames.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Color? color = colors[index%colors.length];
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        instrument = index;
                                        global.trainerUsername = hNames.elementAt(index);
                                        print(global.trainerUsername);
                                        Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.leftToRightWithFade,
                                          child: TrainerUserInfo(),
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
                                                image: "${hImg[index]}"!=""?MemoryImage(base64Decode("${hImg[index]}")):AssetImage('imagess/profilePic.png') as ImageProvider,
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
                                              "${hNames[index].split(" ")[0] + " " + hNames[index].split(" ")[3]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color:  Colors.black,
                                                    
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
                        );
        
  }));

}









Widget Waitforme3() {
  
  return FutureBuilder( future: Future.wait([highlyPImg, highlyPNames]), builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
         
      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          height: MediaQuery.of(context).size.height - 650,
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
                                itemCount: hPNames.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Color? color = colors[index%colors.length];
                                  return InkWell(
                                    onTap: () async{
                                   await getProductsData();
                    int tempIndex=global.tempProductNames.indexOf(hPNames[index]);
                    print(tempIndex);
                      global.productName=hPNames[index];
              global.productPrice=global.tempProductPrices.elementAt(tempIndex);
              global.productImage=hPImg[index];
              global.productAmount=global.tempProductAmounts.elementAt(tempIndex);

              Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: showProductInfo(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
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
                                                image: "${hPImg[index]}"!=""?MemoryImage(base64Decode("${hPImg[index]}")):AssetImage('imagess/profilePic.png') as ImageProvider,
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
                                              "${hPNames[index]}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color:  Colors.black,
                                                    
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
                        );
        
  }));

}










Future getTrainersImages() async {

  var res= await http.get(Uri.parse(global.globall+"/trainers/get-images"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  });

  if(res.statusCode == 200) {
    Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['str'];
    var arrayTrainers = array.split(",");
   int trainersCount12=arrayTrainers.length-1;
    print("trainersCountImage"+trainersCount12.toString());
    for(int i=0; i<trainersCount12; i++) {
      trainersImages.add(arrayTrainers[i]);
    }
    return await [trainersImages];
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

Future getTrainerNames() async {
  var res= await http.get(Uri.parse(global.globall+"/trainers/usernames"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  });
  if(res.statusCode == 200) {
     Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['str'];
     print(array);
    var arrayTrainers = array.split(",");
    trainersCount=arrayTrainers.length-1;
    print("trainersCountNames"+trainersCount.toString());
    for(int i=0; i<trainersCount; i++) {
      var temp = arrayTrainers[i].split(" ");
      print(temp.length);
      tempTreainersUsernames.add(arrayTrainers[i]);
      var temp2 = temp[0]+" "+temp[3];
      trainersNames.add(temp2);
    }
    return await [trainersNames];
  }
  else if(res.statusCode == 401) {
    print("not authenticated");
    return null;
  }

  else if(res.statusCode == 400) {
    print('errorNames');
    return null;
  }
}










Future getHighlyImages() async {

  var res= await http.get(Uri.parse(global.globall+"/trainers/getHighlyRatedImages"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  });

  if(res.statusCode == 200) {
    Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['strImage'];
    var arrayTrainers = array.split(",");

    for(int i=0; (i<arrayTrainers.length-1); i++) {
      hImg.add(arrayTrainers[i]);
    }
    return await DB;
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

Future getHighlyNames() async {
  var res= await http.get(Uri.parse(global.globall+"/trainers/getHighlyRatedNames"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  });
  if(res.statusCode == 200) {
     Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['str'];
    var arrayTrainers = array.split(",");
    print(arrayTrainers );
    for(int i=0; (i<arrayTrainers.length-1); i++) {
      hNames.add(arrayTrainers[i]);
    }
    
    return await DB;
  }
  else if(res.statusCode == 401) {
    print("not authenticated");
    return null;
  }

  else if(res.statusCode == 400) {
    print('errorNames');
    return null;
  }
}



Future getHighlyProductsImages() async {

  var res= await http.get(Uri.parse(global.globall+"/store/getHighlyRatedProductsImages"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  });

  if(res.statusCode == 200) {
    Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['strImage'];
    var arrayTrainers = array.split(",");

    for(int i=0; (i<arrayTrainers.length-1); i++) {
      hPImg.add(arrayTrainers[i]);
    }
    return await DB;
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


Future getHighlyProductsNames() async {
  var res= await http.get(Uri.parse(global.globall+"/store/getHighlyRatedProductsNames"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  });
  if(res.statusCode == 200) {
     Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['str'];
    var arrayTrainers = array.split(",");
    print(arrayTrainers );
    for(int i=0; (i<arrayTrainers.length-1); i++) {
      hPNames.add(arrayTrainers[i]);
    }
    
    return await DB;
  }
  else if(res.statusCode == 401) {
    print("not authenticated");
    return null;
  }

  else if(res.statusCode == 400) {
    print('errorNames');
    return null;
  }
}



Future getProductsData() async {
  var res= await http.get(Uri.parse(global.globall+"/store/allProductsData"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  });
  if(res.statusCode == 200) {
     Map<String, dynamic> DB = jsonDecode(res.body);
     var arrayNames=DB['names'].split(',');
     var arrayPrices=DB['prices'].split(',');
     var arrayAmount =DB['amount'].split(',');
    for(int i=0; (i<arrayNames.length-1); i++) {
      global.tempProductNames.add(arrayNames[i]);
    }

     for(int i=0; (i<arrayPrices.length-1); i++) {
      global.tempProductPrices.add(arrayPrices[i]);
    }

    for(int i=0; (i<arrayAmount.length-1); i++) {
      global.tempProductAmounts.add(arrayAmount[i]);
    }
    
  
    return await DB;
  }
  else if(res.statusCode == 401) {
    print("not authenticated");
    return null;
  }

  else if(res.statusCode == 400) {
    print('errorNames');
    return null;
  }
}

Future checkIfNotify() async{

var res= await http.get(Uri.parse(global.globall+"/users/notify"),headers: {
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
        DB['val'] + " marked your class as completed",
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
