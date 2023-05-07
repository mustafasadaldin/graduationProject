import 'package:flutter/material.dart';
import 'package:flutter_application_2/TrainerSittings/HomePage.dart';
import 'package:flutter_application_2/TrainerSittings/bottomBarTrainer.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/settings/MethodsChat.dart';
import 'package:flutter_application_2/settings/bottomBar.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'dart:convert';
import 'package:page_transition/page_transition.dart';
import 'Admin/HomePage.dart';
import 'home.dart';
import 'settings/HomePage.dart';
import 'settings/Profile.dart';
import 'sign_up.dart';
import 'Forgotpassword.dart';
import 'global.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }
  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  String gender = "";

  TextEditingController Email = TextEditingController();
  TextEditingController Passwoord = TextEditingController();
  bool ispassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
               // color: Colors.black,
    //            gradient: LinearGradient(
    //   begin: Alignment.topLeft,
    //   end: Alignment.bottomRight,
    //   colors: [
    //     Color.fromRGBO(210, 101, 244, 0),
    //     Color.fromRGBO(179, 82, 241, 0),
    //   ],
    // ),

    gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color.fromARGB(255, 15, 105, 202),
              Color(0xff81B2F5),
              // Color(0xff870160),
              // Color(0xffac255e),
              // Color(0xffca485c),
              // Color(0xffe16b5c),
              // Color(0xfff39060),
              // Color(0xffffb56b),
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
                Text(
                  "Hello!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5),
                ),
                Image.asset(
                  "imagess/sport.png",
                  height: 280,
                ),
                SizedBox(
                  height: 20,
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
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            controller: Passwoord,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: ispassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password must  not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                              hintText: "Password",
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(
                                color: Color.fromARGB(255, 56, 54, 54),
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                color: Color.fromARGB(255, 56, 54, 54),
                                onPressed: () {
                                  setState(() {
                                    ispassword = !ispassword;
                                  });
                                },
                                icon: Icon(
                                  ispassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              InkWell(
                                onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          alignment: Alignment.topCenter,
                          child: ForgetPassword(),
                          duration: Duration(milliseconds: 1000),
                        ),
                      );
                    },
                                child: Text(
                                  "Forget Password?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            child: Text("Login"),
                            onPressed: () {
                           login().then((value) => {
                            
                            if(value != null) {
                               logIn(Email.text.trim(), '0597633980##Mm')
                            }
                            else {
                              print(Passwoord.text)
                            }
                           });
                              
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 15, 105, 202),
                              onPrimary: Colors.white,
                              minimumSize: const Size(150, 40),
                              textStyle: TextStyle(
                                fontSize: 18,
                              ),
                              padding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 50, top: 5),
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text("if you don't have account ",
                                  style: TextStyle(fontSize: 15)),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type:
                                          PageTransitionType.bottomToTopJoined,
                                      child: Signup(),
                                      childCurrent: Login(),
                                      duration: Duration(milliseconds: 1000),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Click here",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
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
          )
        ],
      ),
    ));
  }

  void _displayErrorMotionToast() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Invalid Email/Password!'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }

  void _displayErrorMotionToast3() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Please Fill Up All Fields !'),
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
      description: Text('Welcome ' + Email.text),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }

  Future login() async {
    var body1 = jsonEncode({
      'email': Email.text,
      'password': Passwoord.text,
    });

    var res = await http.post(Uri.parse(global.globall + "/login"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body1);


    if (Passwoord.text.isNotEmpty &&
        Email.text.isNotEmpty 
        ) {
        if (res.statusCode == 200) {
        //global.check = 0;
        Map<String, dynamic> DB = jsonDecode(res.body);

        global.token = DB['token'];
        global.logged=DB['logged'];
        global.email=DB['email'];
        if(global.logged!="admin")
        global.username=DB['username'];
        if(global.logged=="admin") {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        _displayErrorMotionToast1();
        return "done";
        }
        else if(global.logged=="user") {
          global.age=DB['age'].toString();
          global.height=DB['height'].toString();
          global.weight=DB['weight'].toString();
          if(DB['ME']!=null)
          global.me=DB['ME'];
          else{
            global.me="";
          }
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bottom_bar()),
        );
        _displayErrorMotionToast1();
        return "done";
        }

        else if(global.logged=="trainer") {
          global.age=DB['age'].toString();
          global.experience=DB['excperience'].toString();
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bottom_barTrainer()),
        );
        _displayErrorMotionToast1();
        return "done";
        }
      
      } else {
         _displayErrorMotionToast();
         return null;
      }
    } else {
       _displayErrorMotionToast3();
       return null;
    }
  }
}
