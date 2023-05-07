import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_application_2/Admin/TabBarTrainers.dart';
import 'package:flutter_application_2/global.dart';
import 'package:flutter_application_2/settings/HomePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import '../global.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class TrainersDetailsAdmin extends StatefulWidget {
  const TrainersDetailsAdmin({super.key});
  @override
  State<TrainersDetailsAdmin> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TrainersDetailsAdmin> {
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
                      child: ShowTrainers(),
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
             
             

             
            ],
          ),
        );

     
        
  }));


}

Future getTrainerInfo() async {
   var body1 = jsonEncode({'username': global.trainerUsername});

    var res = await http.post(Uri.parse(global.globall + "/trainer/all-infoAdmin"),
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



Future getAvgRatingVal() async {
var body1 = jsonEncode({
  "username": global.trainerUsername,
});

var res= await http.post(Uri.parse(global.globall+"/trainer/getTrainerRatingAdmin"),headers: {
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