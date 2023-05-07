import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import '../global.dart';
import 'HomePage.dart';


class changePasswordAdmin extends StatefulWidget {
  const changePasswordAdmin({ Key? key }) : super(key: key);
  

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<changePasswordAdmin> {
  TextEditingController NewPass = TextEditingController();
  TextEditingController ConfPASS = TextEditingController();
  bool ispassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: InkWell(
                    child: Image.asset(
                      'imagess/icons-back.png',
                      height: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      alignment: Alignment.topCenter,
                      child: HomePage(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
                  child: Text(
                    'Change Password',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            FadeInDown(
              delay: Duration(microseconds: 500),
              child: Center(
                child: Image.asset("imagess/change_password.png"),
              ),
            ),
            FadeInDown(
              delay: Duration(microseconds: 500),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: NewPass,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: ispassword,
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
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: TextFormField(
                          cursorColor: Colors.black,
                          controller: ConfPASS,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: ispassword,
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
                        height: 30,
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            modifyPassword();
                          },
                          child: Text("Change Password"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 40),
                            primary: Color.fromARGB(255, 15, 105, 202),
                            onPrimary: Colors.white,
                            padding: EdgeInsets.all(15),
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
            ),
          ],
        ),
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

  void _displayErrorMotionToast3() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('you are not authenticated !'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }


Future <void> modifyPassword() async {
 var body1 = jsonEncode({
  'password': NewPass.text
     });
              
    var res= await http.post(Uri.parse(global.globall+"/admin/update-password"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token': global.token 
  },body: body1);

if(NewPass.text.isNotEmpty&&ConfPASS.text.isNotEmpty) {
  if(NewPass.text!=ConfPASS.text){
  return _displayErrorMotionToast2();
           }

           if(res.statusCode == 200) {
            return _displayErrorMotionToast1();
           }
           if(res.statusCode == 401) {
          return _displayErrorMotionToast3();
           }
           if(res.statusCode == 400) {
            if(res.body == "too weak password") {
              _displayErrorMotionToastPassword();
            }
           }
} else {
    return _displayErrorMotionToast();
}
}


}