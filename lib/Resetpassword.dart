import 'package:flutter/material.dart';
import 'package:flutter_application_2/settings/MethodsChat.dart';
import 'dart:convert';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:http/http.dart' as http;
import 'global.dart';
import 'LOG.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ResetPasswordState();
  }
}

class ResetPasswordState extends State<ResetPassword> {
  TextEditingController NewPass = TextEditingController();
  TextEditingController ConfPASS = TextEditingController();
  bool ispassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
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
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: InkWell(
                  child: Image.asset(
                    'imagess/bcak.png',
                    color: Colors.white,
                    height: 30,
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
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
                    "Reset Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5),
                  ),
                ),
                Image.asset(
                  "imagess/res2.png",
                  height: 200,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            controller: NewPass,
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
                              hintText: "New Password",
                              labelText: 'New Password',
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
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            cursorColor: Colors.black,
                            controller: ConfPASS,
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
                              hintText: "Confirm new Password",
                              labelText: 'Confirm new Password',
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              ResetPass();
                            },
                            child: Text("Reset"),
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
      description: Text('Please Fill Up the fields!'),
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
      description: Text('New password is confirmed :)'),
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
      description: Text('Password must be matched !'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }

  void _displayErrorMotionToast9() {
    MotionToast.error(
      title: Text(
        "Error",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Password Must Be > 7'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }

  void _displayErrorMotionToast10() {
    MotionToast.error(
      title: Text(
        "Error",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Password Must Be > 7'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }


void _displayErrorMotionToastPassword() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('password must be at least 8 characters of 2 digits, 1 symbol,uppercase,lowercase'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 120,
    ).show(context);
  }




  Future<void> ResetPass() async{
   

      var body1 = jsonEncode({
  'password': NewPass.text,
  'email': global.email
     });
              
    var res= await http.post(Uri.parse(global.globall+"/update-password"),headers: {
      'Content-Type': 'application/json; charset=UTF-8'//,
      //'token': 'Bearer ' + globalss.authToken 
  },body: body1);
   //Map<String,dynamic> DB = jsonDecode(res.body);
  //print(res.statusCode);
        
    if(NewPass.text.isNotEmpty&&ConfPASS.text.isNotEmpty){
           if(NewPass.text!=ConfPASS.text){
  return _displayErrorMotionToast2();
           }
           if(res.statusCode==200){
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
              return _displayErrorMotionToast1();
     }
      if(res.statusCode == 400) {
      
      if(res.body == "too weak password") {
        _displayErrorMotionToastPassword();
      }
      else if(res.body == "invalid credantials") {
        print('test');
      }
     } 
    
    }
     else {
        
              return _displayErrorMotionToast();
     }
 
    }
}
