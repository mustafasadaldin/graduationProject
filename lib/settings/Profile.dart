// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/global.dart';
import 'package:flutter_application_2/settings/bottomBar.dart';
import 'package:flutter_application_2/settings/calander.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'About.dart';
import 'Edit_Profile.dart';
import 'HomePage.dart';
import 'PersonalTrainerUserProfile.dart';
import 'Search.dart';
import 'Settings_Page.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
bool _isListViewVisible = false;
  late Future img;
int _selectedIndex = 0;

  final List<Widget> _pages = [
     HomePage_user(),
     SearchList(),
     Settings_Page(),
     Profile(),
  ];
   void initState(){
    super.initState();
    img=image2();
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
                      child: bottom_bar(),
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
                title: Center(child: Text(global.username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19
                ),
                )),
                subtitle: Center(child: Text('Participent')),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.contact_page,
                    color: Colors.green,
                  ),
                  title: Text('Age',
                  style: TextStyle(
                    fontSize: 18
                  ),
                  
                  ),
                  subtitle: 
                  Text(global.age,
                  style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 17              
                     ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.height_outlined,
                    color: Colors.orange,
                  ),
                  title: Text('Height',
                  style: TextStyle(
                    fontSize: 19
                  ),
                  ),
                  subtitle: Text(global.height,
                  
                  style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 17            
                     ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.line_weight_outlined,
                    color: Colors.blue,
                  ),
                  title: Text('Weight',
                   style: TextStyle(
                    fontSize: 19
                  ),
                  ),
                  subtitle: Text(global.weight,
                  style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 17               
                     ),
                  ),
                ),
              ),

               Card(
                child: ListTile(
                  leading: Icon(
                    Icons.lock_clock,
                    color: Colors.yellow,
                  ),
                  title: Text('MemberShip End',
                   style: TextStyle(
                    fontSize: 19
                  ),
                  ),
                  subtitle: Text(global.me!=""?global.me:"not have public registeration until now",
                  style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 17               
                     ),
                  ),
                ),
              ),
              
GestureDetector(
  onTap: () {
     getUserPersonalTrainers();
            setState(() {
              _isListViewVisible = !_isListViewVisible;
            });
          },
           child:   Card(
                child: ListTile(
                  leading: Icon(
                    Icons.sports_kabaddi_sharp,
                    color: Colors.red,
                  ),
                  title: Text('My personal trainers',
                  style: TextStyle(
                    fontSize: 19
                  ),
                  ),
                 // subtitle: Text("click here",style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
                ),
              ),

         
),


SizedBox(height: 10,),

GestureDetector(
  onTap: () {
    Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: calander(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );    
            setState(() {
              _isListViewVisible = !_isListViewVisible;
            });
          },
           child:   Card(
                child: ListTile(
                  leading: Icon(
                    Icons.calendar_view_week_rounded,
                    color: Colors.indigo,
                  ),
                  title: Text('My PT classes',
                  style: TextStyle(
                    fontSize: 19
                  ),
                  ),
                 // subtitle: Text("click here",style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
                ),
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

var res= await http.post(Uri.parse(global.globall+"/users/image1"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  }, body: body1);

if(res.statusCode==200) {
  setState(() {
    image1 = res.body;
  });

}
return await image1;
  }


  void _displayErrorMotionToast512() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('you do not have personal trainers !'),
      
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
      width: 300,
      
    ).show(context);
  }

Future getUserPersonalTrainers() async {
  var body1 = jsonEncode({
  "username": global.trainerUsername,
});


var res= await http.post(Uri.parse(global.globall+"/trainers/getPersonalUsernames"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);
print(res.statusCode);
  if(res.statusCode == 200) {
    if(res.body=='empty'){
    print('here');
    return _displayErrorMotionToast512();
    }
Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: PersonalTrainerUserProfile(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );    
 
  }

  else if(res.statusCode == 400) {
    print('error');
  }

  else if(res.statusCode == 401) {
    print('not authenticated');
  }

}


}
