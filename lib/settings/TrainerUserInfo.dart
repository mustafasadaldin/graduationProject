import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_application_2/global.dart';
import 'package:flutter_application_2/settings/HomePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'About.dart';
import 'Edit_Profile.dart';
import 'Profile.dart';
import 'Settings_Page.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import '../global.dart';
import 'TrainerBreaks.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'bottomBar.dart';

class TrainerUserInfo extends StatefulWidget {
  const TrainerUserInfo({super.key});
  @override
  State<TrainerUserInfo> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TrainerUserInfo> {
   late Future trainersMap;
    var experience="";
    var age=0;
    var email="";
    var image="";
    var startWorkHours="";
    var endWorkHours="";
    var ratingValue=0.0;
    var location="";
       late Future avgRating;
   void initState(){
    super.initState();
    trainersMap = getTrainerInfo();
    avgRating = getAvgRatingVal();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
          title: Text('Trainer Profile'),
          leading: IconButton(
          onPressed: () {
           Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: bottom_bar(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
          },
          icon: Icon(Icons.arrow_back),
        ),
        ),
         body: Waitforme()
    );
   
  }


Widget Waitforme() {
  
  return FutureBuilder( future: Future.wait([trainersMap,avgRating]) , builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
        
            SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
               Center(
              child: CircleAvatar(
                child: Align(
                  alignment: Alignment.bottomRight,
                ),
                radius: 90,
                backgroundImage: image!=""? MemoryImage(base64Decode(image)):AssetImage('imagess/profilePic.png') as ImageProvider,
              ),
            ),

            
           
                
                Center(
                    child: SmoothStarRating(
                      starCount: 5,
                      rating: ratingValue,
                      onRated: (v) {
                        setState(() {
                          print(v);
                        });
                        setStarRate(v);
                      },
                      allowHalfRating: true,
                      color: Color.fromARGB(255, 255, 191, 52),
                      borderColor: Color.fromARGB(255, 255, 191, 52),
                    ),
           
                  ),
                 
             
             
              ListTile(
                title: Center(child: Text(global.trainerUsername,
                style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19
                ),
                )),
                subtitle: Center(child: Text('Trainer')),
              ),

              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.work_history_sharp,
                    color: Colors.green,
                  ),
                  title: Text('Working Hours'),
                  subtitle: Text(startWorkHours.toString()+" - "+endWorkHours.toString()),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  title: Text('Gym Location'),
                  subtitle: Text(location),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.work,
                    color: Colors.orange,
                  ),
                  title: Text('Experience'),
                  subtitle: Text(experience),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                  title: Text('Email'),
                  subtitle: Text(email),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Do you like To take personal training with him ?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(
                height: 5,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 122),
                child: Container(
                            margin: EdgeInsets.only( bottom: 30),
                            child: ElevatedButton(
                              child: Text("Reserve"),
                              onPressed: () {
                               getIfRegistered();
                               
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 15, 105, 202),
                                onPrimary: Colors.white,
                                minimumSize: const Size(150, 40),
                                textStyle: TextStyle(
                                  fontSize: 18,
                                ),
                                padding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
              ),
            ],
          ),
        );

     
        
  }));


}

Future getTrainerInfo() async {
   var body1 = jsonEncode({'username': global.trainerUsername});

    var res = await http.post(Uri.parse(global.globall + "/trainer/all-info"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': global.token
        },
        body: body1);

        if(res.statusCode == 200) {
          Map<String,dynamic> DB=jsonDecode(res.body);
          experience=DB['experience'];
          age=DB['age'];
          email=DB['email'];
          image=DB['image'];
          startWorkHours=DB['startWorkHoures'].toString();
          endWorkHours=DB['endWorkHoures'].toString();
          location=DB['location'];
          print(location);
          return DB;
        }
        else if(res.statusCode == 400) {
          print('error');
        }
        else if(res.statusCode == 401) {
          print('not authenticated');
        }
}
void _displayErrorMotionToast() {
    MotionToast.info(
      title: Text(
        'Info',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('when you finish your registration come back :)'),
      
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
      width: 300,
      
    ).show(context);
  }

Future getIfRegistered() async {
      print(global.trainerUsername);
var body1 = jsonEncode({
  "username": global.trainerUsername
});

var res= await http.post(Uri.parse(global.globall+"/trainers/regWith"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

  if(res.statusCode == 200) {
   
     if(res.body == "found") {
          return _displayErrorMotionToast();
          
     }
     else if(res.body=="ok") {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BMII())
        );
     }
    
 }

 else if(res.statusCode == 400) {
 print('error');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }
}

Future<void> setStarRate(var value) async {
var body1 = jsonEncode({
  "username": global.trainerUsername,
  "numberOfStars":value
});

var res= await http.post(Uri.parse(global.globall+"/trainer/rating"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

  if(res.statusCode == 200) {

    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrainerUserInfo())
        );
  }

  else if(res.statusCode == 400) {
 print('error');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }


}

Future getAvgRatingVal() async {
var body1 = jsonEncode({
  "username": global.trainerUsername,
});

var res= await http.post(Uri.parse(global.globall+"/trainer/getTrainerRating"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

  if(res.statusCode == 200) {
    print(res.body);
    ratingValue = double.parse(res.body);
    return await ratingValue;
  }

  else if(res.statusCode == 400) {

 print('error');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }
}
}