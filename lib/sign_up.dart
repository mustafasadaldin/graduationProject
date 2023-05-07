import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/settings/MethodsChat.dart';
import 'package:flutter_application_2/settings/bottomBar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'global.dart';
import 'LOG.dart';
import 'settings/HomePage.dart';
import 'settings/Profile.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  // var gender;
  int value = 0;
  bool ispassword = true;
  var formkey = GlobalKey<FormState>();
   String dropdownValue = 'Nablus';


  Widget CustomRadioButton(
      String text, int index, TextEditingController Gendeer) {
    return OutlinedButton(
      //hoverColor: Colors.pink,
      onPressed: () {
        Gendeer.text = text;
        setState(() {
          value = index;

          TextFormField(
            controller: Gendeer,
          );
        });
      },
      //padding: EdgeInsets.all(15),
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.black : Colors.grey,
        ),
      ),
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //borderSide:
      // BorderSide(color: (value == index) ? Colors.pink.shade600 : Colors.black),
    );
  }

  @override
  TextEditingController User = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Age = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController CPassword = TextEditingController();
  //TextEditingController PhoneN = TextEditingController();
  TextEditingController Gendeer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
            child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.39,
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
                margin: EdgeInsets.only(top: 42, left: 10, right: 10),
                child: GestureDetector(
                    child: Image.asset(
                      'imagess/icons8-return-100.png',
                      color: Colors.white,
                      height: 50,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.topToBottom,
                          alignment: Alignment.topCenter,
                          child: Login(),
                          duration: Duration(milliseconds: 1000),
                        ),
                      );
                    }),
              ),
            ],
          ),
          Center(
              child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                "A&M GYM",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5),
              ),
              Image.asset(
                "imagess/sport.png",
                height: 200,
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          cursorColor: Colors.black,
                          controller: User,
                          keyboardType: TextInputType.name,
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
                            hintText: 'Full Name',
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            prefixIcon: Icon(
                              color: Color.fromARGB(255, 56, 54, 54),
                              Icons.person,
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
                          controller: Email,
                          keyboardType: TextInputType.emailAddress,
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
                          controller: Age,
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
                            hintText: ' Age',
                            labelText: 'Age',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            prefixIcon:
                                Icon(color: Color.fromARGB(255, 56, 54, 54), Icons.date_range),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: TextFormField(
                          cursorColor: Colors.black,
                          controller: Password,
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
                      SizedBox(
                        height: 5,
                      ),
                      

PopupMenuButton<String>(
    
      itemBuilder: (BuildContext context) {
    
return <PopupMenuEntry<String>>[
    
  PopupMenuItem<String>(
    
    value: 'Nablus',
    
    child: ListTile(
    
      title: Text('Nablus'),
    
    ),
    
  ),
    
  PopupMenuItem<String>(
    
    value: 'Ramallah',
    
    child: ListTile(
    
      title: Text('Ramallah'),
    
    ),
    
  ),
    
  PopupMenuItem<String>(
    
    value: 'Jenen',
    
    child: ListTile(
    
      title: Text('Jenen'),
    
    ),
    
  ),
    
];
    
      },
    
      onSelected: (String value) {
    
setState(() {
    
  dropdownValue = value;
  print(dropdownValue);
    
});
    
      },
    
      child: ListTile(
    leading: Text('Gym Location:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0),),
title: Text(dropdownValue),
    
trailing: Icon(Icons.arrow_drop_down),
    
      ),
    
    ),




                      Container(
                        margin: EdgeInsets.all(8),
                        height: 45,
                        child: Row(
                          children: [
                            Text('Gender :'),
                            SizedBox(
                              width: 10.0,
                            ),
                            CustomRadioButton("Male", 1, Gendeer),
                            Text("     "),
                            CustomRadioButton("Female", 2, Gendeer),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          width: 160.0,
                          child: MaterialButton(
                            onPressed: () {
                               login().then((value) => {
                                
                                  if(value != null) {
                                    createAccount(User.text, Email.text, '0597633980##Mm').then((value) => {
                                      if(value!=null) {
                                          Navigator.push(
       context,
        MaterialPageRoute(builder: (context) => bottom_bar()),
           ),
                _displayErrorMotionToastValid()
                                      }
                                      else {
                                        print('error')
                                      }
                                    })
                                  }

                                  else {
                                    print('error')
                                  }
                                });                    
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.white,
                                 fontSize: 18,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromARGB(255, 15, 105, 202),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ))
        ])));
  }

  void _displayErrorMotionToast() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Please Fill All the Fields!'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }

  void _displayErrorMotionToast1() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Invalid Email'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }

  void _displayErrorMotionToast4() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This User name is already used!'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }

  void _displayErrorMotionToast6() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This Email is already used!'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }

  void _displayErrorMotionToastUser() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This name is already used by other users!'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }



void _displayErrorMotionToastuserNameInvalid() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('you must enter your full Quadruple name'),
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



  void _displayErrorMotionToastEmail() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This email is already used by other users!'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }

  void _displayErrorMotionToastValid() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('New User Regestired Successfuly'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }

  Future login() async {
    var body1 = jsonEncode({
      'userName': User.text,
      'email': Email.text,
      'password': Password.text,
      'gender': Gendeer.text,
      'age': Age.text,
      'location':dropdownValue
    });

    var res = await http.post(Uri.parse(global.globall + "/users/sign-up"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body1);

    if (Gendeer.text.isNotEmpty &&
        User.text.isNotEmpty &&
        Email.text.isNotEmpty &&
        Password.text.isNotEmpty &&
        Age.text.isNotEmpty) {
      if (!(Email.text.contains(RegExp(r'[@]')) &&
          Email.text.contains('.com'))) {
         _displayErrorMotionToast1();
         return null;
      }

      print("Code:${res.statusCode}");
      if (res.body == "not unique username") {
        _displayErrorMotionToastUser();
        return null;
      }
      if (res.body == "not unique email") {
        _displayErrorMotionToastEmail();
        return null;
      }

      if(res.body == "too weak password") {
        _displayErrorMotionToastPassword();
        return null;
      }

      if(res.body == "invalid username") {
        _displayErrorMotionToastuserNameInvalid();
        return null;
      }

      if (res.statusCode == 201) {
        Map<String, dynamic> DB = jsonDecode(res.body);
        global.token=DB['token'];
        global.email=Email.text;
        global.logged="user";
        global.username=DB['username'];
        global.height=DB['height'].toString();
        global.weight=DB['weight'].toString();
        global.age=DB['age'].toString();
        global.me="";
        
      

                return "done";

      }
    } else {
      _displayErrorMotionToast();
      return null;
    }
  }
}
