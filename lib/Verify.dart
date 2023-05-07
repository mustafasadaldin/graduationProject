import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'global.dart';
import 'LOG.dart';
import 'Resetpassword.dart';

class Verify extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VerifyState();
  }
}

class VerifyState extends State<Verify> {
  TextEditingController pin = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
                gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color.fromARGB(255, 15, 105, 202),
              Color(0xff81B2F5),
            ],
    ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Verify account',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5),
                    ),
                  ),
                ),
                Image.asset(
                  "imagess/verified-account.png",
                  height: 300,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            controller: pin,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              hintText: 'pin code',
                              labelText: 'pin code',
                              prefixIcon: Icon(
                                color: Color.fromARGB(255, 56, 54, 54),
                                Icons.verified,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              verifyPin();
                              //Navigator.of(context).pushNamed("verify");
                            },
                            child: Text(
                              'Confirm',
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(150, 40),
                              primary: Color.fromARGB(255, 15, 105, 202),
                              onPrimary: Colors.white,
                              padding: EdgeInsets.all(10),
                              textStyle: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }


void _displayErrorMotionToast() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('pin is not correct !'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }



void _displayErrorMotionToast1() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Update your password !'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }


void _displayErrorMotionToast2() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Please Enter the sended pin'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }

Future<void> verifyPin() async {
    var body1 = jsonEncode({'email': global.email, 'pin' : pin.text});

    
      var res = await http.post(Uri.parse(global.globall + "/verification-code"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body1);

         //  Map<String, dynamic> DB = jsonDecode(res.body);
//  print(res.body);
 //   print(res.statusCode);
 //global.email=DB['email'];

    if (pin.text.isNotEmpty) {
      if (res.statusCode == 200) { 
        
         /*
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPassword()),
        );
        */
        Navigator.of(context).pushNamed("Resetpassword");
         _displayErrorMotionToast1();
      } else {
         _displayErrorMotionToast();
      }
    } else {
      return _displayErrorMotionToast2();
    }
  }


}
