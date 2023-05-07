import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_application_2/global.dart';
import 'package:flutter_application_2/settings/HomePage.dart';
import 'package:flutter_application_2/settings/Search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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

import 'TrainerDetailsFromUser.dart';

class PersonalTrainerUserProfile extends StatefulWidget {
  const PersonalTrainerUserProfile({super.key});
  @override
  State<PersonalTrainerUserProfile> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PersonalTrainerUserProfile> {
   late Future trainersMap;
    var experience="";
    var age=0;
    var email="";
    var image="";
    var remCalsses=0;
    var startWorkHours="";
    var endWorkHours="";
    var ratingValue=0.0;
    var location="";
    var personalTrainerList=[];
    var personalTrainerTempList1=[];
    var personalTrainerTempList2=[];
    var personalTrainerImageList=[];
    var personalTrainerRateList=[];
    var colors = [
    Color(0xff06CA88),
    Color(0xffEBAD48),
    Color.fromARGB(255, 103, 96, 233),
    Color(0xffFD5A49),
  ];
    var flag=false;
       late Future avgRating;
       late Future personalTrainers;
       late Future personalImages;
       var tempStr="";
       var newTimes="";

       int _selectedIndex = 0;

  final List<Widget> _pages = [
     HomePage_user(),
     SearchList(),
     Settings_Page(),
     Profile(),
  ];
   void initState() {
    super.initState();
    personalTrainers =  getUserPersonalTrainers();
    avgRating=getAvgRatingVal();
    personalImages=getPersonalTrainersImages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor: Color(0xff81B2F5),
          title: Text('My Trainers'),
          leading: IconButton(
          onPressed: () {
            global.counter=0;
           Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: Profile(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
          },
          icon: Icon(Icons.arrow_back),
        ),
        ),

        
        
         body: 
         SafeArea(
          child:Center(
            child: ListView(children: [
          Waitforme(),
          SizedBox(
            height: 15.0,
          ),
           
            ],),
          ) 
         
         
         ), 
             
          
    
         
    );
   
  }


Widget Waitforme() {
  
  return FutureBuilder( future: Future.wait([personalTrainers, avgRating, personalImages]) , builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
        
       Padding(
        padding: EdgeInsets.only( left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 630,
              child: ListView.separated(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: personalTrainerList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(indent: 16),
                itemBuilder: (BuildContext context, int index) {
                  Color? color = colors[index%colors.length];
                return InkWell(
                  onTap: () {
                    global.trainerImage=personalTrainerImageList[index];
                    global.trainerRate=double.parse(personalTrainerRateList[index]);
                    global.trainerUsername=personalTrainerList[index];
                    
                         Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: TDetails(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                  },
                  child: Container(
                    width: 283,
                    height: 199,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 231, 241, 241),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 77,
                            height: 54,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(32)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${personalTrainerList[index].split(" ")[0]}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "${personalTrainerList[index].split(" ")[3]}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 2.5,
                                  ),
                                  Text(
                                    "${personalTrainerRateList[index]}",
                                    style: GoogleFonts.sansita(
                                        color: Color.fromARGB(255, 58, 57, 57)),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SmoothStarRating(
                                    size: 20,
                                    rating: 5,
                                    defaultIconData: Icons.star,
                                    starCount: 1,
                                    color: Colors.red,
                                    borderColor: Colors.red,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 77,
                            height: 54,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32)),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 80,
                          top: 0,
                          child: SizedBox(
                            width: 100,
                            height: 140,
                            child: Hero(
                              tag: "${personalTrainerList[index]}",
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 80,
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundImage:
                                      "${personalTrainerImageList[index]}"!=""?MemoryImage(base64Decode("${personalTrainerImageList[index]}")):AssetImage('imagess/profilePic.png') as ImageProvider,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
  },
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
          MaterialPageRoute(builder: (context) => PersonalTrainerUserProfile())
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

var res= await http.post(Uri.parse(global.globall+"/trainers/getPersonalTrainersRates1"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

  if(res.statusCode == 200) {
    Map<String,dynamic> DB=jsonDecode(res.body);
    var array3=DB['strRate'].split(",");
    for(int i=0; i<(array3.length-1);i++) {
  personalTrainerRateList.add(array3[i]);
 }
 print(personalTrainerRateList.length);
    return await [personalTrainerRateList];
  }

  else if(res.statusCode == 400) {

 print('errorAvg');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }
}



Future getPersonalTrainersImages() async {
  var body1 = jsonEncode({
  "username": global.trainerUsername,
});

var res= await http.post(Uri.parse(global.globall+"/trainers/getPersonalTrainersImages1"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);


  if(res.statusCode == 200) {
    Map<String,dynamic> DB=jsonDecode(res.body);
   var array2=DB['strImage'].split(",");
    for(int i=0; i<(array2.length-1);i++) {
  personalTrainerImageList.add(array2[i]);
 }

 print(personalTrainerImageList.length);
    return await [personalTrainerImageList];
  }

  else if(res.statusCode == 400) {

 print('errorAvg');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }
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
      Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: Profile(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
      
    return _displayErrorMotionToast512;
    }

 Map<String,dynamic> DB=jsonDecode(res.body);
 var array=DB['str'].split(",");
 for(int i=0; i<(array.length-1);i++) {
  personalTrainerList.add(array[i]);
 }

print(personalTrainerList.length);
 return await[personalTrainerList];
  }

  else if(res.statusCode == 400) {
    print('error');
  }

  else if(res.statusCode == 401) {
    print('not authenticated');
  }

}

Future personalTrainerProfileInfo() async{
   var body1 = jsonEncode({
  "username": global.trainerUsername,
});

var res= await http.post(Uri.parse(global.globall+"/trainers/personalTrainerProfileInfo"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

  if(res.statusCode == 200) {
Map<String,dynamic> DB=jsonDecode(res.body);
 var array=DB['str'].split(",");
 for(int i=0; i<(array.length-1);i++) {
  newTimes = newTimes + array[i] +"\n";
 }
 remCalsses=DB['numberOfClasses'];
  }
}
}