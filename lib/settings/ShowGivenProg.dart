// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter_application_2/settings/ShowMyPrograme.dart';
import 'package:flutter_application_2/settings/bottomBar.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global.dart';

class program extends StatefulWidget {
  buildStyles(BuildContext, int index) {}
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<program> {

  late Future allData;
  List names=[];

  @override
  void initState() {
    super.initState();
    allData = getTrainers();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        shadowColor: Colors.blue,
        title: Text('Given programs'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                child: bottom_bar(),
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
              padding: const EdgeInsets.only(left: 8),
              child: Padding(
                padding: const EdgeInsets.only(left: 110.0),
                child: Text(
                  'Programs:',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Waitforme()
          ],
        ),
      ),
    );
  }

  Widget Waitforme() {
  
  return FutureBuilder( future: allData, builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
          
          
            Expanded(
              child: Container(
                // height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: names.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(

                          onTap: () {
                                      setState(() {
                                        global.trainerUsername = names.elementAt(index);
                                        print(global.trainerUsername);
                                        Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.leftToRightWithFade,
                                          child: ShowExercises(),
                                          duration: Duration(milliseconds: 1000),
                                        ),
                                      );
                                      });
                                    },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            // width: 30,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 15,
                                      offset: Offset(5, 5))
                                ]),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Image.asset(
                                    'imagess/gym.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 2, top: 123),
                                      child: Container(
                                        color: Colors.grey,
                                        child: Text(
                                         "${names[index].split(" ")[0] + " "+ names[index].split(" ")[3] + " program" }",
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                                        ),
                                      ),
                                    )
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

Future getTrainers() async {

var body1 = jsonEncode({'username': "empty"});

    var res = await http.post(Uri.parse(global.globall + "/users/testRouter"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': global.token
        },
        body: body1);

        if(res.statusCode == 200) {
 Map<String,dynamic> DB=jsonDecode(res.body);
          var array=DB['str'].split(',');

          for(int i=0; i<(array.length-1); i++) {
            names.add(array[i]);
          }

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
