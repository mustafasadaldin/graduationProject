import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_application_2/TrainerSittings/HomePage.dart';
import 'package:flutter_application_2/TrainerSittings/tapbar.dart';
import 'package:flutter_application_2/global.dart';
import 'package:flutter_application_2/settings/HomePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
import 'package:smooth_star_rating/smooth_star_rating.dart';


class TodayCompleted extends StatefulWidget {
  const TodayCompleted({super.key});
  @override
  State<TodayCompleted> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TodayCompleted> {
List usersDays=[];
List usersTimes=[];
List tempImages=[];
List tempNames=[];
String name="";
String day="";
String session="";
late Future allData; 
   void initState() {
    super.initState();
 allData=getTodatClasses();
  }
  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    return Scaffold(
    
        
         body: Waitforme()
      
             
            
      
             
          
         
    );
   
  }

Widget Waitforme() {
  
  return FutureBuilder( future: allData, builder:((context, snapshot)  {
      Size size = MediaQuery.of(context).size;

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
           SafeArea(

        child:  Column(
          children: [
          
      Expanded(
              child: Container(
                height: size.height * 0.6,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: tempNames.length,
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
            )
                ]
        ),
        
         
         
         ) ;
          

        
  }));
}



Future getTodatClasses() async{
  DateTime now = DateTime.now();
print(DateFormat('EEEE', 'en_US').format(now).trim());
  var body1 = jsonEncode({
  "day": DateFormat('EEEE', 'en_US').format(now).trim(),
});

var res= await http.post(Uri.parse(global.globall+"/users/getCompleted"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

  
if(res.statusCode == 200) {
  if(res.body.isEmpty)
  return await "empty";

    Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['strTimes'];
    var arrayUsers = array.split(",");
    
    for(int i=0; i<(arrayUsers.length-1); i++) {
     var temp=arrayUsers[i].split(":");
     usersDays.add(temp[0]);
     usersTimes.add(temp[1]);
     tempImages.add(temp[2]);
     tempNames.add(temp[3]);
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

}

