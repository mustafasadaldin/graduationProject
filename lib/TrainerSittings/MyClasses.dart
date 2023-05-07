import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_application_2/TrainerSittings/HomePage.dart';
import 'package:flutter_application_2/global.dart';
import 'package:flutter_application_2/settings/HomePage.dart';
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
import 'package:smooth_star_rating/smooth_star_rating.dart';


class MyClasses extends StatefulWidget {
  const MyClasses({super.key});
  @override
  State<MyClasses> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyClasses> {

 var _selectedMenuIndex=0;
 List _menuItems=['itme1', 'item2', 'item3'];
   void initState() {
    super.initState();
   
  }
  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    return Scaffold(
    
        
         body: 
         SafeArea(

        child:  Column(
          children: [

      Expanded(
              child: Container(
                height: size.height * 0.6,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: global.globalCountForUsers,
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
                                                image: "${global.images[index]}"!=""?MemoryImage(base64Decode("${global.images[index]}")):AssetImage('imagess/profilePic.png') as ImageProvider,
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
                                          "${global.names[index].split(" ")[0] + " " +global.names[index].split(" ")[3]}",
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
                                            "${global.days[index]}"
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
                                              "${global.times[index]}",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
            
                          
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
        
         
         
         ) 
             
          
         
    );
   
  }



}