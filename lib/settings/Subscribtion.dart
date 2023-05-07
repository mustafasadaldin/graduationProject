// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
import 'HomePage.dart';
import 'Profile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as file;
import 'dart:async';
import 'Settings_Page.dart';
import 'package:flutter_application_2/global.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;
import 'dart:io' as file;

import 'TrainerBreaks.dart';
import 'TrainerUserInfo.dart';

import 'package:intl/intl.dart';

import 'bottomBar.dart';

class Subscribtion extends StatefulWidget {
  const Subscribtion({Key? key}) : super(key: key);

  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<Subscribtion> {
  bool isMale = true;
  int number = 12;
  var flag2=0;
  var diff=0;
  TextEditingController Time = TextEditingController();
  bool _verticalList = false;
  var instrument = 0;
    DateTime now = DateTime.now();
    String startDate="";
    String endDate="";
  ScrollController _scrollController = ScrollController();
  List<Color> _colors =
      List.generate(12, (index) => Colors.black); // initial list of colors
  int value = 0;
 var breaksCount = 0;
 var tempTreainerBreaks=[];
 var tempIndex=[1,2,3,4,5,6,7,8,9,10,11,12];
 late   var _razorpay;
  var amountController = TextEditingController();
   void initState(){
     _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
     super.initState();
     diff=0;
  }
  
 void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
     breakUserMemberShip();
    print("Payment Done");
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
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 500) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Subscribtions"),
        centerTitle: true,
         backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
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
      
      body: SafeArea(
          child: Column(
        children: [
           SizedBox(
            height: 25.0,
          ),
          Center(
           child: Text("How many monthes do you need ?",
           style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
           )
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 4,
                  children: List.generate(12, (index) {
                    
                    return InkWell(
                     
                      onTap: () async{
                        
               
                        // change the color of the tapped container to red, and all other containers to blue
                            startDate = DateFormat('yyyy-MM-dd').format(now);
                            await checkEndDate();
                            print((30*tempIndex[index])+diff);
                            setState(() {
                           flag2 = index;
                                  });
DateTime nextMonthDate =now.add(Duration(days: (30*tempIndex[index])+diff));
 endDate = DateFormat('yyyy-MM-dd').format(nextMonthDate);

                      },
                      child: Container(
                       decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 242, 125),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 6,color : flag2!=index?  Colors.white:Colors.orange),
                ), 
                        child: Center(
                          child: Text(
                            
                          "${tempIndex[index]} month",
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
          ),
         
          SizedBox(
            height: 30.0,
          ),
          Container(
            width: 280,
            color: Colors.black,
            height: 55.0,
            margin: EdgeInsets.only(bottom: 140),
            child: MaterialButton(
              
               color: Color.fromARGB(255, 15, 105, 202),
              onPressed: () async{
                // breakUserMemberShip();
               await callPaymentApi();
              },
              child: Text(
                "Subscribe Your Choice !",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
      )),
    );
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







Future<void> breakUserMemberShip() async {
global.me=endDate;
var body1 = jsonEncode({
  "membershipStart": startDate,
  "membershipEnd":endDate,
});

var res= await http.post(Uri.parse(global.globall+"/trainer/membership"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

  if(res.statusCode == 200) {
   return _displayErrorMotionToastValid();
  }

  else if(res.statusCode == 400) {
   return print('error');
  }

  else if(res.statusCode == 401) {
    return print('not authenticated');
  }

} 

Future<void> checkEndDate() async {
  var body1 = jsonEncode({
  "membershipStart": startDate,
  "membershipEnd":endDate,
});

var res= await http.post(Uri.parse(global.globall+"/user/getMemberShipEnd"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);
  if(res.statusCode == 200) {

  Map<String, dynamic> DB = jsonDecode(res.body);

        var memberShipData = DB['membershipEnd'];
  print(memberShipData);
        if(memberShipData == "user") {
          diff=0;
        }

        else {
            diff=0;
         String tempDate = DateFormat('yyyy-MM-dd').format(now);
         DateTime tempDateNow = DateTime.parse(tempDate);
          DateTime date = DateTime.parse(memberShipData);
          if (date.compareTo(tempDateNow) < 0) {
  print('$tempDateNow is larger than $date');
  diff=0;
} else if (date.compareTo(tempDateNow) > 0) {
  print('$date is larger than $tempDateNow');
  Duration difference = date.difference(tempDateNow);
  diff=difference.inDays;
                              print("diff= "+diff.toString());
} else {
  diff=1;
}
        }

  }

  else if(res.statusCode == 400) {
    print('error');
  }

  else if(res.statusCode == 401) {
    print('not authenticated');
  }
}

}