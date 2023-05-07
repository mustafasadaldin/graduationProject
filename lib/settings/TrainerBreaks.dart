// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
import 'Profile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as file;
import 'dart:async';
import 'Settings_Page.dart';
import 'package:flutter_application_2/global.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;
import 'dart:io' as file;

import 'TrainerUserInfo.dart';
import 'package:input_history_text_field/input_history_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BMII extends StatefulWidget {
  const BMII({Key? key}) : super(key: key);

  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMII> {
  bool isMale = true;
  int number = 12;
  TextEditingController Time = TextEditingController();
  bool _verticalList = false;
  var instrument = 0;
  var daysCount=0;
  String _selectedItem="";
  ScrollController _scrollController = ScrollController();
  List<Color> _colors =
      List.generate(12, (index) => Colors.black); // initial list of colors
  int value = 0;
 var breaksCount = 0;
 var tempTreainerBreaks=[];
 var tempTrainerDays=[];
 var flag=false;
  late Future trainersBreaks;
  List trainerDaysList=[];
  List trainerBreaksList=[];
  List calenderTest=[];
  int flag2=0;
  var iconColor=Colors.white;
   late   var _razorpay;
  var amountController = TextEditingController();

   void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    // Do something when payment succeeds
    await deleteFromFreeTimes();
       Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: TrainerUserInfo(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                          return _displayErrorMotionToastValid();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }


 Future <void> callPaymentApi() async{
     var options = {
                    'key': "rzp_test_xzYxlJyA9lwukq",
                    // amount will be multiple of 100c
                    'amount':  100
                        .toString(), //So its pay 500
                    'name': 'Code With Patel',
                    'currency':"USD",
                    'description': 'Demo',
                    'timeout': 300, // in seconds
                    'prefill': {
                      'contact': '8787878787',
                      'email': 'codewithpatel@gmail.com'
                    }
                  };
                  _razorpay.open(options);
  }
  void initState(){
     _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
    trainersBreaks = getTrainerDays();
  }
  

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 500) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Reservasion"),
         actions: [

            IconButton(
                color: iconColor,//calenderTest.isNotEmpty?Color.fromARGB(255, 0, 245, 9):Colors.white,
                onPressed: () {
               if(calenderTest.length>=1){
                    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
      final Size screenSize = MediaQuery.of(context).size;
      final double menuWidth = screenSize.width * 0.8;
      final double menuHeight = calenderTest.length * kMinInteractiveDimension;
      final position = RelativeRect.fromLTRB(
        screenSize.width - menuWidth,
        kToolbarHeight,
        0.0,
        screenSize.height - kToolbarHeight - menuHeight,
      );
                      
                           showMenu(
                             context: context,
                             position: position,
                             items: calenderTest.map((item) {
                               return PopupMenuItem(
                                 value: item,
                                 child: Text(item, style: TextStyle(fontWeight: FontWeight.bold),),
                               );
                             }).toList(),
                           ).then((value) {
                             if (value != null) {
                               setState(() {
                               });
                             }
                           });
                }
                
                },
             

                icon: Icon(Icons.calendar_month, color: iconColor)),




            IconButton(
                color: iconColor,//calenderTest.isNotEmpty?Color.fromARGB(255, 0, 245, 9):Colors.white,
                 tooltip: 'Undo',
                onPressed: () {
                  Undo();
                },
             

                icon: Icon(Icons.undo, color: iconColor)),

          ],
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
          
         leading: IconButton(
          onPressed: () {
           Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: TrainerUserInfo(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
          },
          icon: Icon(Icons.arrow_back),
        ),

      ),
      
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 90.0,
          ),
          Waitforme(),
          SizedBox(
            height: 80.0,
          ),
         


          // SizedBox(
          //   height: 30.0,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Number of classes you need to take:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height:10.0
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              heroTag: "minus",
                              backgroundColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  number--;
                                });
                              },
                              mini: true,
                              child: Icon(
                                Icons.remove,
                                color: Colors.orange,
                              ),
                            ),

                            SizedBox(width: 10,),

                            Text(
                          "${number}",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),

                        SizedBox(width: 10,),
                            FloatingActionButton(
                              heroTag: "plus",
                              backgroundColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  number++;
                                });
                              },
                              mini: true,
                              child: Icon(
                                Icons.add,
                                color: Colors.orange,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),


Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 15, bottom: 50),
                          child: ElevatedButton(
                            child: Text("Subscribe !"),
                            onPressed: () async{
await callPaymentApi();
               
              


                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 15, 105, 202),
                              onPrimary: Colors.white,
                              minimumSize: const Size(150, 40),
                              textStyle: TextStyle(
                                fontSize: 18,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 110),
                            ),
                          ),
                        ),


        ],
      )),
    );
  }

Widget Waitforme() {
  
  return FutureBuilder( future: trainersBreaks, builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
         

         Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20),
              child: Container(

                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff81B2F5),
                  boxShadow:  [
  BoxShadow(
    color: Colors.blue,
    spreadRadius: 1,
    blurRadius: 15
  )
],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GridView.count(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 4,
                  children: List.generate(daysCount, (index) {
                    
                    return InkWell(
                     
                      onTap: () async{
                        // change the color of the tapped container to red, and all other containers to blue
                        
                          global.trainerday = tempTrainerDays.elementAt(index);
                         flag2=index;
                           await getTrainersBreaks();
                    
                    final RenderBox overlay =
                      Overlay.of(context).context.findRenderObject() as RenderBox;
                                    final RenderBox inkWellBox =
                      context.findRenderObject() as RenderBox;
                                    final position = RelativeRect.fromRect(
                    Rect.fromPoints(
                      inkWellBox.localToGlobal(Offset.zero, ancestor: overlay),
                      inkWellBox.localToGlobal(
                          inkWellBox.size.bottomRight(Offset.zero),
                          ancestor: overlay),
                    ),
                    Offset.zero & overlay.size,
                                    );
                      
                           showMenu(
                             context: context,
                             position: position,
                             items: tempTreainerBreaks.map((item) {
                               return PopupMenuItem(
                                 value: item,
                                 child: Text(item, style: TextStyle(fontWeight: FontWeight.bold),),
                               );
                             }).toList(),
                           ).then((value) {
                             if (value != null) {
                               setState(() {
                                 _selectedItem = value as String;
                                 //trainerBreaksList.insert(index, _selectedItem);
                                 reservation();
                                 print( trainerBreaksList);
                               });
                             }
                           });
                     
                        // child: Container(
                        //   padding: EdgeInsets.all(16.0),
                        //   child: Text(_selectedItem),
                        // );
                     
                      },
                      child: Container(
                        decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 242, 125),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 6,color : flag2!=index?  Colors.white:Colors.orange),
                ), // use the corresponding color from the list
                        child: Center(
                          child: Text(
                            
                            "${tempTrainerDays[index]}",
                            style: 
                            TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
     
        
  }));
 

}

void _displayErrorMotionToastValid() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Reserved Successfuly'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }


  void _displayErrorMotionToastValid558() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('There is a scheduling conflict'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }

  void _displayErrorMotionToastValid17() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('you already choose time in this day !'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }


Future getTrainersBreaks() async {
var body1 = jsonEncode({
  "username": global.trainerUsername,
  "workingDay":global.trainerday
});

var res= await http.post(Uri.parse(global.globall+"/trainers/breaks"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

  print(number);
print(res.statusCode);
  if(res.statusCode == 200) {
    tempTreainerBreaks=[];
   Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['str'];
    var arrayTrainers = array.split(",");
    breaksCount=arrayTrainers.length-1;
    print(breaksCount);
    for(int i=0; i<breaksCount; i++) {
      tempTreainerBreaks.add(arrayTrainers[i]);
    }
    return await [tempTreainerBreaks];
 }

 else if(res.statusCode == 400) {
 print('error');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }
}

Future<void> deleteFromFreeTimes() async {
  String databaseDays="";
  String databaseBreaks="";
  for(int i=0;i<trainerDaysList.length;i++) {
    databaseDays=databaseDays + trainerDaysList.elementAt(i) + ",";
  }

  for(int i=0;i<trainerBreaksList.length;i++) {
    databaseBreaks=databaseBreaks + trainerBreaksList.elementAt(i) + ",";
  }
  var body1 = jsonEncode({
  "username": global.trainerUsername,
  "breakTime":databaseBreaks,
  "numberOfClasses":number,
  "day":databaseDays
});

var res= await http.post(Uri.parse(global.globall+"/trainers/reserveTime"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

  if(res.statusCode == 200) {
    if(res.body=="conflict"){
      flag=true;
    }
    //return _displayErrorMotionToastValid558();
   
  }

  else if(res.statusCode == 400) {
 print('error');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }

}


Future getTrainerDays() async {
  var body1 = jsonEncode({
  "username": global.trainerUsername,
});

var res= await http.post(Uri.parse(global.globall+"/trainers/getWorkingDays"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);
print(res.statusCode);
  if(res.statusCode == 200) {
    Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['str'];
     print(array);
    var comingDays = array.split(",");
    daysCount=comingDays.length-1;
    print(breaksCount);
    for(int i=0; i<daysCount; i++) {
      tempTrainerDays.add(comingDays[i]);
    }
    return await [tempTrainerDays];
  }

  else if(res.statusCode == 400) {
    print('error');
  }

  else if(res.statusCode == 401) {
    print('not authenticated');
  }
}

Future<void> checkConflict() async {
  var body1 = jsonEncode({
  "username": global.trainerUsername,
  "breakTime":_selectedItem,
  "day":global.trainerday
});
  print("in2");

var res= await http.post(Uri.parse(global.globall+"/trainers/checkConflict"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);
print(res.statusCode);
  if(res.statusCode == 200) {
    if(res.body=="conflict"){
      print("conflict");
     flag=true;
    }
    else{
    flag=false;
    }
    //return _displayErrorMotionToastValid558();
   
  }

  else if(res.statusCode == 400) {
 print('error');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }

}

void reservation() async {
  if(!trainerDaysList.contains(global.trainerday)){
                  print('in');
                   await checkConflict();
                  if(!flag){
                  print(trainerDaysList.contains(global.trainerday));
                trainerBreaksList.add(_selectedItem);
                trainerDaysList.add(global.trainerday);
                 calenderTest.add(global.trainerday+ " : "+ _selectedItem);
                if(calenderTest.length>0) {
                   setState(() {
                  iconColor=Color.fromARGB(255, 0, 245, 9);
                  });
                }
                else{
                  setState(() {
                  iconColor=Colors.white;
                   });
                }
                print(trainerBreaksList);
                print(trainerDaysList);
                  }
                  else if(flag) {
                    return _displayErrorMotionToastValid558();
                  }
                }
                else{
                 return _displayErrorMotionToastValid17();
                }
}

void Undo() async {
  trainerBreaksList.removeLast();
  trainerDaysList.removeLast();
  calenderTest.removeLast();
  print(trainerBreaksList);
  print(trainerDaysList);
  print(calenderTest);
}

}