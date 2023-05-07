import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
import 'Verify.dart';
import 'global.dart';
import 'LOG.dart';
import 'Resetpassword.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgetPasswordState();
  }
}

class ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController Email = TextEditingController();
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
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 45, left: 10, right: 10),
                child: InkWell(
                  child: Image.asset(
                    'imagess/bcak.png',
                    color: Colors.white,
                    height: 30,
                  ),
                  onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          alignment: Alignment.topCenter,
                          child: Login(),
                          duration: Duration(milliseconds: 1000),
                        ),
                      );
                    },
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Forget Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5),
                  ),
                ),
                Image.asset(
                  "imagess/forget.png",
                  height: 400,
                ),
                
                Container(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            controller: Email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email must  not be empty';
                              }
                              return null;
                            },
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
                              hintText: 'Email',
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(
                                color: Color.fromARGB(255, 56, 54, 54),
                                Icons.email,
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
                              Forget();
                            },
                            child: Text("Send code"),
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

  void _displayErrorMotionToast1() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Please Enter Your Pin'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }

  void _displayErrorMotionToast() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('The Email Is Invalid !'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
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
      description: Text('Please Enter An Email!'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }

  Future<void> Forget() async {
    var body1 = jsonEncode({'email': Email.text});

    
      var res = await http.post(Uri.parse(global.globall + "/forget-password"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: body1);

         //  Map<String, dynamic> DB = jsonDecode(res.body);
//  print(res.body);
 //   print(res.statusCode);
 //global.email=DB['email'];

    if (Email.text.isNotEmpty) {
      if (res.statusCode == 200) {
        global.email = Email.text;
       // globalss.VerifyPage = 2;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Verify()),
        );
        
         _displayErrorMotionToast1();
      } else {
         _displayErrorMotionToast();
      }
    } else {
      return _displayErrorMotionToast2();
    }
  }
}
