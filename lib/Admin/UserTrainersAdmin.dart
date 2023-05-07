
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/Admin/ShowUserDetails.dart';
import 'package:flutter_application_2/global.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';

import 'package:http/http.dart' as http;
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../global.dart';


class UserTrainersAdmin extends StatefulWidget {
  const UserTrainersAdmin({super.key});
  @override
  State<UserTrainersAdmin> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UserTrainersAdmin> {
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
          title: Text('User Trainers'),
          leading: IconButton(
          onPressed: () {
            global.counter=0;
           Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: UserProfileAdmin(),
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


  void _displayErrorMotionToast512() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('He do not have personal trainers !'),
      
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
      width: 300,
      
    ).show(context);
  }




Future getAvgRatingVal() async {
var body1 = jsonEncode({
  "name": global.userUserName,
});

var res= await http.post(Uri.parse(global.globall+"/trainers/getPersonalTrainersRates1Admin"),headers: {
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
  "name": global.userUserName,
});

var res= await http.post(Uri.parse(global.globall+"/trainers/getPersonalTrainersImages1Admin"),headers: {
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
  "name": global.userUserName,
});

var res= await http.post(Uri.parse(global.globall+"/trainers/getPersonalUsernamesAdmin"),headers: {
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
                      child: UserProfileAdmin(),
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


}