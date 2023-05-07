import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_application_2/Admin/UserTrainersAdmin.dart';
import 'package:flutter_application_2/Admin/UsersTabBar.dart';
import 'package:flutter_application_2/TrainerSittings/HomePage.dart';
import 'package:flutter_application_2/TrainerSittings/SearchListUser.dart';
import 'package:flutter_application_2/TrainerSittings/SearchListUserBar.dart';

import 'dart:convert';


import 'package:flutter_application_2/global.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
import '../global.dart';








class UserProfileAdmin extends StatefulWidget {
  @override
  State<UserProfileAdmin> createState() => _UDetailsState();
}

class _UDetailsState extends State<UserProfileAdmin> {
  var About1 = "bjjkgjgkggjkgj";
  var rating = 2.0;
  var rating1;
  bool rate = true;
  var email = "";
  String image = "";
  String location = "";
  var age = "";
  var me = "";
  
  var flag=false;

late Future img;

  @override
  void initState() {
    super.initState();
   
    img=getClickedUserAllInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 10),
                  child: InkWell(
                    child: Image.asset(
                      'imagess/icons-back.png',
                      height: 20,
                    ),
                    onTap: () {
                       Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: ShowUsers(),
                          duration: Duration(milliseconds: 1000),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
                  child: Text(
                    'User info',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
           Waitforme(),
          
GestureDetector(
  onTap: () async{
   await getUserPersonalTrainers();
          },
           child:   Card(
                child: ListTile(
                  leading: Icon(
                    Icons.sports_kabaddi_sharp,
                    color: Colors.blue,
                  ),
                  title: Text('User personal trainers',
                  style: TextStyle(
                    fontSize: 19
                  ),
                  ),
                ),
              ),

         
),
          ],
        ),
      ),
    );
  }

Widget Waitforme() {
  
  return FutureBuilder( future: Future.wait([img]), builder:((context, snapshot)  {

  return snapshot.data==null?  Center(child: CircularProgressIndicator()): 

  Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                image: "${image}"!=""?MemoryImage(base64Decode("${image}")):AssetImage('imagess/profilePic.png') as ImageProvider,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 7,
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
                image: "${image}"!=""?MemoryImage(base64Decode("${image}")):AssetImage('imagess/profilePic.png') as ImageProvider,
                                foregroundDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    global.userUserName.split(" ")[0] + " " + global.userUserName.split(" ")[3],
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
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    location,
                                    style: TextStyle(
                                      color: Color(0xff1E1C61).withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          
                         
                          

                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Age',
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
                            age,
                            style: TextStyle(
                                height: 1.6,
                                color: Color(0xff1E1C61).withOpacity(0.7),
                                fontSize: 19),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'MemberShip End',
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
                            me!=""?me:"not have public registeration until now",
                            style: TextStyle(
                                height: 1.6,
                                color: Color(0xff1E1C61).withOpacity(0.7),
                                fontSize: 19),
                          ),
                          SizedBox(
                            height: 10,
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



Future getClickedUserAllInfo() async {
  var body1 = jsonEncode({
  "name": global.userUserName,
});

var res= await http.post(Uri.parse(global.globall+"/admin/getUserInfoAdmin"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);


  if(res.statusCode == 200) {
  Map<String, dynamic> DB = jsonDecode(res.body);
  email=DB['email'];
  print(email);
  location=DB['location'];
  print(location);
  age=DB['age'];
  print(age);
  image=DB['image'];
  if(DB['me']!=null)
  me=DB['me'];
  else
  me="";
  
return DB;
  }

  else if(res.statusCode == 400) {
 print('error');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }
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
     
      
    return _displayErrorMotionToast512();
    }

 Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: UserTrainersAdmin(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );

}
}
}
