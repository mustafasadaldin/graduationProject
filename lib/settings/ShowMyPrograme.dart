// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter_application_2/TrainerSittings/test.dart';
import 'package:flutter_application_2/settings/ShowGivenProg.dart';
import 'package:flutter_application_2/settings/bottomBar.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global.dart';

class ShowExercises extends StatefulWidget {
  buildStyles(BuildContext, int index) {}
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<ShowExercises> {

  List names=[];
  List days=[];
  List images=[];
  List duration=[];
  late Future allData;

  @override
  void initState() {
    super.initState();
    allData=getMyExe();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        shadowColor: Colors.blue,
        title: Text('My Program'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                child: program(),
                duration: Duration(milliseconds: 1000),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 110),
              child: Text(
                'Exercises:',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Waitforme()
          ],
        ),
      ),
    );
  }

Widget Waitforme() {
  
  return FutureBuilder( future: allData, builder:((context, snapshot)  {
    Size size = MediaQuery.of(context).size;
      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 

            Expanded(
              child: Container(
                height: size.height * 0.6,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: names.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(

                             onTap: () async{
                                      setState(() {
                                        global.exerciseName=names.elementAt(index);
                                      });
                                      await getExe();
                                       Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => videooo(desc: global.desc),
  ),
);
                                    },

                          child: Container(
                            width: size.width * 0.6,
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
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image(
                                            height: 70.0,
                                            width: 70.0,
                                           image: "${images[index]}"!=""?MemoryImage(base64Decode("${images[index]}")):AssetImage('imagess/sport.png') as ImageProvider,
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
                                            "${names[index]}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.today_outlined),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                "${days[index]}",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w500),
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
                                                "${duration[index]}",
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
                        ),
                      );
                    }),
              ),
            );
     

        
  }));
}

Future getMyExe() async {

var body1 = jsonEncode({
  "trainerName": global.trainerUsername,
});


var res= await http.post(Uri.parse(global.globall+"/users/getMyExercisesUser"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

if(res.statusCode == 200) {
    Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['strExe'];
    var arrayUsers = array.split(",");
    for(int i=0; i<(arrayUsers.length-1); i++) {
     var temp=arrayUsers[i].split(":");
     names.add(temp[0]);
     days.add(temp[1]);
     duration.add(temp[2]);
     images.add(temp[3]);
    }

    return await [images];
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



Future getExe() async {
  var body1 = jsonEncode({'name': global.exerciseName});

  var res = await http.post(Uri.parse(global.globall + "/trainer/getDetailsExercises"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': global.token,
        'cache-control': 'no-cache',
      },
      body: body1);

  if(res.statusCode == 200) {
    Map<String,dynamic> DB=jsonDecode(res.body);

global.desc=DB['desc'];
global.url=DB['url'];
    return DB;

  } else if(res.statusCode == 400) {
    print('error');
  } else if(res.statusCode == 401) {
    print('not authenticated');
  }
}

}
