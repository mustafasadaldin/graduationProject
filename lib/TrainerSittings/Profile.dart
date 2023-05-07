// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/TrainerSittings/bottomBarTrainer.dart';
import 'package:flutter_application_2/global.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'About.dart';
import 'Edit_Profile.dart';
import 'HomePage.dart';
import 'SearchListUser.dart';
import 'Settings_Page.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class ProfileTrainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<ProfileTrainer> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  late Future img;
int _selectedIndex = 0;
var avgRate=0.0;
  final List<Widget> _pages = [
     HomePage_trianer(),
     SearchListUser(),
     Settings_Page(),
     ProfileTrainer(),
  ];
  late Future Rate;
  void initState(){
    super.initState();
    img=image2();
    Rate=getRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
          title: Text('My Profile'),
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
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Row(
                  children: [
                    SizedBox(
                      height: 50.0,
                      width: 100.0,
                    ),
                    Text(
                      'My Profile',
                      //textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Waitforme(),
              ListTile(
                title: Center(child: Text(global.username)),
                subtitle: Center(child: Text('Participent')),
                
              ),
 
             Waitforme2(),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.contact_page,
                    color: Colors.yellow,
                  ),
                  title: Text('Age'),
                  subtitle: Text(global.age),
                ),
              ),

              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.work,
                    color: Colors.grey,
                  ),
                  title: Text(
                    'Experiences ',
                  ),
                  subtitle: Text(global.experience),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        

    

        );
  }

Widget Waitforme2() {
  
  return FutureBuilder( future: Rate, builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
         Center(
                    child: SmoothStarRating(
                      starCount: 5,
                      rating: avgRate,
                      isReadOnly: true,
                      onRated: (v) {
                        setState(() {
                          print(v);
                        });
                      },
                      allowHalfRating: true,
                      color: Color.fromARGB(255, 255, 191, 52),
                      borderColor: Color.fromARGB(255, 255, 191, 52),
                    ),
           
                  );

        
  }));
}


Widget Waitforme() {
  
  return FutureBuilder( future: img, builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
          Center(
              child: CircleAvatar(
                child: Align(
                  alignment: Alignment.bottomRight,
                ),
                radius: 90,
                backgroundImage: image1!=""? MemoryImage(base64Decode(image1)):AssetImage('imagess/profilePic.png') as ImageProvider,
              ),
            );

        
  }));
}

var image1="";
Future image2() async{
var body1 = jsonEncode({
  "email": global.email
});

var res= await http.post(Uri.parse(global.globall+"/trianers/image1"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  }, body: body1);

if(res.statusCode==200) {
  setState(() {
    image1 = res.body;
  });
}
return await image1;
  }

Future getRate() async {
var res= await http.get(Uri.parse(global.globall+"/trainers/getMyRatePls"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  });

  if(res.statusCode == 200) {
 Map<String, dynamic> DB = jsonDecode(res.body);
        avgRate = double.parse(DB['avgRate'].toString().trim());
        print(avgRate);

        return await avgRate;
  }

  else if(res.statusCode==400) {
    print('error');
  }

  else if(res.statusCode == 401) {
    print('not authenticated');
  }

}
}
