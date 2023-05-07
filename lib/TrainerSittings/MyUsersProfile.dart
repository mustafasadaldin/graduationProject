import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_application_2/TrainerSittings/HomePage.dart';
import 'package:flutter_application_2/TrainerSittings/uploadexercise.dart';

import 'dart:convert';


import 'package:flutter_application_2/global.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import '../global.dart';
import 'bottomBarTrainer.dart';








class UDetails extends StatefulWidget {
  @override
  State<UDetails> createState() => _UDetailsState();
}

class _UDetailsState extends State<UDetails> {
  var About1 = "bjjkgjgkggjkgj";
  var rating = 2.0;
  var rating1;
  bool rate = true;
  var email = "";
  String image = "";
  String location = "";
  var age = 0;
  var weight = "";
  var height="";
  var number=0;
  var flag=false;

late Future img;

  @override
  void initState() {
    super.initState();
   
    img=getClickedUserAllInfoImage();
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
                          child: bottom_barTrainer(),
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
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'Number of classes',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xff1E1C61),
                                ),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                number.toString(),
                                style: TextStyle(
                                    height: 1.6,
                                    color: Color(0xff1E1C61).withOpacity(0.7),
                                    fontSize: 19),
                              ),
                              SizedBox(
                                width: 250.0,
                              ),
                              
                            ],
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
                            age.toString(),
                            style: TextStyle(
                                height: 1.6,
                                color: Color(0xff1E1C61).withOpacity(0.7),
                                fontSize: 19),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Weight',
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
                            weight.toString(),
                            style: TextStyle(
                                height: 1.6,
                                color: Color(0xff1E1C61).withOpacity(0.7),
                                fontSize: 19),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Height',
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
                            height.toString(),
                            style: TextStyle(
                                height: 1.6,
                                color: Color(0xff1E1C61).withOpacity(0.7),
                                fontSize: 19),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                         Container(
                          padding: EdgeInsets.only( top: 5),
                          
                          child: Row(
                            children: [
                            
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type:
                          PageTransitionType.rightToLeftWithFade,
                                      child: exerc(),
                                      childCurrent: UDetails(),
                                      duration: Duration(milliseconds: 1000),
                                    ),
                                  );
                                },
                                child: Container(
                                 // color: Colors.grey,
                                  child: Text(
                                    "Add a program",
                                    style: TextStyle(
                                      
                                      fontSize: 20,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                     
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
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

// image:user.image.toString("base64"),
//     location:user.location,
//     email:user.email,
//     age:user.age,
//     height:user.height,
//     weight:user.weight,
//     numberOfCalsses:array[0].classesNumber


Future getClickedUserAllInfo() async {
  var body1 = jsonEncode({
  "username": global.userUserName,
});

var res= await http.post(Uri.parse(global.globall+"/users/getMyUserAllInfo"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);


  if(res.statusCode == 200) {
  Map<String, dynamic> DB = jsonDecode(res.body);
    //   print(jsonDecode(res.body));
  email=DB['email'];
  print(email);
  location=DB['location'];
  print(location);
  age=DB['age'];
  print(age);
  height=DB['height'].toString();
  print(height);
  weight=DB['weight'].toString();
  print(weight);
  number=int.parse(DB['numberOfCalsses'].toString());
  print(number);
  

return DB;
  }

  else if(res.statusCode == 400) {
 print('error');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }
}
  


Future getClickedUserAllInfoImage() async {
  print('hsfkjhfdjkdfshdfsjhdsfkjfh');
  var body1 = jsonEncode({
  "username": global.userUserName,
});

var res= await http.post(Uri.parse(global.globall+"/users/getMyUserAllInfoImage"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

print(res.statusCode);
  if(res.statusCode == 200) {
  Map<String, dynamic> DB = jsonDecode(res.body);
       //print(jsonDecode(res.body));
  image=DB['image'];
  await getClickedUserAllInfo();
   return image;
  }

  else if(res.statusCode == 400) {
 print('error');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }
}




}
