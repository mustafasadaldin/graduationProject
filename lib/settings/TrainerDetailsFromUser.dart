import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_application_2/settings/HomePage.dart';
import 'package:flutter_application_2/settings/Search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../TrainerSittings/Settings_Page.dart';
import '../global.dart';
import 'PersonalTrainerUserProfile.dart';
import 'Profile.dart';
class TDetails extends StatefulWidget {
  @override
  State<TDetails> createState() => _TDetailsState();
}

class _TDetailsState extends State<TDetails> {
 
late Future info;
var About1="bjjkgjgkggjkgj";
var rating = 2.0;
var rating1;
bool rate =true;
 var email="";
var startWorkHours="";
var endWorkHours="";
var location="";
var ratingValue=0.0;
var numberOfClasses=0;
int _selectedIndex = 0;

  final List<Widget> _pages = [
     HomePage_user(),
     SearchList(),
     Settings_Page(),
     Profile(),
  ];
 @override
  void initState(){
        super.initState();

  //  About = GetAbout();

  info=getPressedTrainerInfo();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: InkWell(
                    child: Image.asset(
                      'imagess/icons-back.png',
                      height: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: PersonalTrainerUserProfile(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
                 
                  child: Text(
                    'Trainer info',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.black),
                        
                  ),
                ),
              ],
            ),
           Waitforme()
           
          ],
        ),
      ),

      
      
    );
  }
  Widget Waitforme() {
  
  return FutureBuilder(future:info, builder:((context, snapshot)  {

     return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
      
      Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image:"${global.trainerImage}"!=""?MemoryImage(base64Decode("${global.trainerImage}")):AssetImage('imagess/profilePic.png') as ImageProvider,

                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child:  Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.24,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffF9F9F9),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              
                              AdvancedAvatar(
                                                size: 100,
                                image: "${global.trainerImage}"!=""?MemoryImage(base64Decode("${global.trainerImage}")):AssetImage('imagess/profilePic.png') as ImageProvider,
                                                foregroundDecoration:
                                                    BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    global.trainerUsername.split(" ")[0],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xff1E1C61),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    email,
                                    style: TextStyle(
                                      color: Color(0xff1E1C61).withOpacity(0.7),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      
                                      
                                     if(rate) SmoothStarRating(

                                        starCount: 5,
                                        rating: ratingValue,
                                        allowHalfRating:true,
                                          onRated: (v) {
                                      setState(() {
                                         rating=v;
                                        setStarRate(v);
                                        
                                       });
                                       
                                    },
                                   

                                        color: Color.fromARGB(255, 255, 191, 52),
                                        borderColor: Color.fromARGB(255, 255, 191, 52),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      if(rate)
                                      Text(
                                      
                                       ratingValue.toString(),
                                        style: GoogleFonts.sansita(
                                            color: Colors.grey[700]),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Reamaning classes for you',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xff1E1C61),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                          
                            numberOfClasses.toString(),
                            style: TextStyle(
                              height: 1.6,
                              color: Color(0xff1E1C61).withOpacity(0.7),
                              fontSize: 19
                            ),
                          ),
                        SizedBox(
                            height: 30,
                        ),
                         
                              Text(
                           'Location',
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 18,
                             color: Color(0xff1E1C61),
                           ),
                              ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                          
                            location,
                            style: TextStyle(
                              height: 1.6,
                              color: Color(0xff1E1C61).withOpacity(0.7),
                              fontSize: 19
                            ),
                          ),


                           SizedBox(
                            height: 30,
                        ),
                         
                              Text(
                           'Working houres',
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 18,
                             color: Color(0xff1E1C61),
                           ),
                              ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                          
                            startWorkHours+" - "+endWorkHours,
                            style: TextStyle(
                              height: 1.6,
                              color: Color(0xff1E1C61).withOpacity(0.7),
                              fontSize: 19
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
      
      

  }));
}

Future getPressedTrainerInfo() async {

var body1 = jsonEncode({'username': global.trainerUsername});

    var res = await http.post(Uri.parse(global.globall + "/trainer/all-info"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': global.token
        },
        body: body1);
        if(res.statusCode == 200) {
          Map<String,dynamic> DB=jsonDecode(res.body);
        
          email=DB['email'];
          startWorkHours=DB['startWorkHoures'].toString();
          endWorkHours=DB['endWorkHoures'].toString();
          location=DB['location'];
          await getAvgRatingVal();
          await getNumberOfClasses();
          return DB;
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
          MaterialPageRoute(builder: (context) => TDetails())
        );
  }

  else if(res.statusCode == 400) {
 print('error');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }
}



Future getNumberOfClasses() async {

var body1 = jsonEncode({'username': global.trainerUsername});

    var res = await http.post(Uri.parse(global.globall + "/trainer/getUserPersonalRate"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': global.token
        },
        body: body1);
        if(res.statusCode == 200) {
          Map<String,dynamic> DB=jsonDecode(res.body);
          numberOfClasses=DB['numberOfClasses'];
          return DB;
        }
        else if(res.statusCode == 400) {
          print('error');
        }
        else if(res.statusCode == 401) {
          print('not authenticated');
        }
  }




}




