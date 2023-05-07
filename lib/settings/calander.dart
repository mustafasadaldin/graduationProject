import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/settings/Profile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/src/intl/date_format.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_application_2/global.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
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
import 'Subscribtion.dart';
import 'TrainerUserInfo.dart';
import 'package:intl/date_symbol_data_local.dart';

class calander extends StatefulWidget {
  const calander({Key? key}) : super(key: key);

  @override
  _calanderState createState() => _calanderState();
}

class _calanderState extends State<calander> {

  late Future getReg;
List<TimeRegion> list=[];
  @override
  void initState() {
    super.initState();
    getReg=getTimeRegions();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
       backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
        title: Text('Calsses time'),
        leading: IconButton(
          onPressed: () {
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
     body:Waitforme()
    );
  }

 





Widget Waitforme() {
  
  return FutureBuilder( future: Future.wait([getReg]), builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
     Container(
      child: SfCalendar(
        view: CalendarView.week,
        specialRegions: list,

          allowedViews: [
            CalendarView.day,
            CalendarView.week
          ],
         timeSlotViewSettings: TimeSlotViewSettings(
   timeIntervalHeight: 50, // change time slot height
    timeIntervalWidth: 0,
    timeTextStyle: TextStyle(
      color: Colors.black, // change time slot text color to black
      fontSize: 17, // change time slot text size
    ),
  ),
  backgroundColor: Colors.white, // change background color to white
  headerStyle: CalendarHeaderStyle(
    textStyle: TextStyle(
      color: Color.fromARGB(255, 15, 105, 202), // change header text color to blue
      fontSize: 20, // change header text size
    ),
    backgroundColor: Colors.grey[200], // change header background color to grey
  ),


          viewHeaderStyle: ViewHeaderStyle(
          
    dateTextStyle: TextStyle(
      
      color: Colors.black, // change date text color to black
      fontSize: 18, // change date text size
    ),
    dayTextStyle: TextStyle(
      color: Colors.black, // change day text color to grey
      fontSize: 16, // change day text size
    ),
  ),

   

          
      ),
    );
        
  }));

}

//List<TimeRegion>
//str+array[i].day+":"+array[i].session +","
  Future getTimeRegions() async{

var body1 = jsonEncode({'username': global.trainerUsername});
     var res = await http.post(Uri.parse(global.globall + "/trainers/getMyReservedTimes"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': global.token
        },
        body: body1);

  if(res.statusCode == 200) {
    Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['str'].split(',');
     var arrayTemp=DB['str2'].split(',');
     for(int i=0;i<(array.length-1);i++) {

var temp=array[i].split(":");
String dayOfWeek = temp[0]; // Replace with the desired day of the week
var temp2=temp[1].split("-");
DateTime now = DateTime.now();
DateTime nextDate = now.add(Duration(days: now.weekday - now.weekday));
while (DateFormat('EEEE', 'en_US').format(nextDate) != dayOfWeek) {
  nextDate = nextDate.add(Duration(days: 1));
}

DateTime newDateTime = DateTime(nextDate.year, nextDate.month, nextDate.day, int.parse(temp2[0].trim()), 0, 0);
String formattedDate = DateFormat('yyyy-MM-dd').format(nextDate);
print(formattedDate);

    list.add(TimeRegion(
        startTime: newDateTime,
        endTime: newDateTime.add(Duration(hours: 1)),
        enablePointerInteraction: true,
        color: Colors.blue,
        text: arrayTemp[i],
         textStyle: TextStyle(
        color: Colors.white, // set text color to white
        fontSize: 16, // set text size
        ),
       
        ),
        
        
        );
     }
   
    return await [list];
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