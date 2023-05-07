import 'dart:convert';
import 'package:flutter_application_2/settings/MethodsChat.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Admin/HomePage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../global.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class Signup_Trainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup_Trainer> {
  // var gender;
  int value = 0;
  bool ispassword = true;
  var formkey = GlobalKey<FormState>();
  bool val = false;
  bool val1 = false;
  final List<String> _weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  List<String> _selectedDays = [];
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
    );
  }

  TextEditingController UserName = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Age = TextEditingController();
  TextEditingController From = TextEditingController();
  TextEditingController To = TextEditingController();
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
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
          ),
          
          Center(
              child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                "Hire a trainer",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5),
              ),
              SizedBox(
                height: 30,
              ),
              Image.asset(
                "imagess/signup.png",
                height: 180,
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
                          controller: UserName,
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
                            hintText: 'User Name',
                            labelText: 'User Name',
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
                        height: 15,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Text(
                              'Working hours :',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          ]),
                          Row(
                        children: [
                          Container(
                            width: 65,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: From,
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
                                hintText: 'From',
                                labelText: 'From',
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                                hintStyle: TextStyle(fontSize: 5.0),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 15),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Text(
                            'AM',
                            style: TextStyle(fontSize: 10.0),
                          ),
                          Switch(
                            value: val,
                            onChanged: (newvalue) {
                              setState(() {
                                val = newvalue;
                              });
                              print(val);
                            },
                            activeColor: Colors.blue,
                            inactiveTrackColor: Colors.blue,
                          ),
                          Text(
                            'PM',
                            style: TextStyle(fontSize: 10.0),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: 65,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: To,
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
                                hintText: 'To',
                                labelText: 'To',
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                                hintStyle: TextStyle(fontSize: 20.0),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 15),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Text(
                            'AM',
                            style: TextStyle(fontSize: 10.0),
                          ),
                          Switch(
                            value: val1,
                            onChanged: (newvalue) {
                              setState(() {
                                val1 = newvalue;
                              });
                            },
                            activeColor: Colors.blue,
                            inactiveTrackColor: Colors.blue,
                          ),
                          Text(
                            'PM',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 5,
                      ),

              
MultiSelectFormField(
          autovalidate: AutovalidateMode.disabled,
          title: Text('Working days', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          dataSource: _weekdays
              .map((day) => {'display': day, 'value': day})
              .toList(),
          textField: 'display',
          valueField: 'value',
          okButtonLabel: 'OK',
          cancelButtonLabel: 'CANCEL',
          hintWidget: Text('Please choose one or more days'),
          initialValue: _selectedDays,
          onSaved: (value) {
            if (value == null) return;
            setState(() {
              _selectedDays = List<String>.from(value);
            });
          },
        ),
                  
                  SizedBox(
                        height: 10,
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
    leading: Text('Gym Location:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
title: Text(dropdownValue),
    
trailing: Icon(Icons.arrow_drop_down),
    
      ),
    
    ),

                      SizedBox(
                        height: 5,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 40,
                          child: Row(
                            children: [
                              Text(
                                'Gender :',
                                style: TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              CustomRadioButton("Male", 1, Gendeer),
                              SizedBox(
                                width: 20,
                              ),
                              CustomRadioButton("Female", 2, Gendeer),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          width: 150.0,
                          child: MaterialButton(
                            onPressed: () {
                              signUp().then((value) => {
                                if(value!=null) {
                                createAccount(UserName.text, Email.text, '0597633980##Mm').then((value) => {
                                  if(value!=null) {
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
                              'Add trainer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
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

  void _displayErrorMotionToastValid() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('New Trainer Regestired Successfuly'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }

Future  signUp() async {
var x = int.parse(From.text);
var y = int.parse(To.text);
if(val) {
x = x + 12;
}
if(val1) {
  y+=12;
}

String tempString="";
for(int i=0;i<_selectedDays.length;i++) {
tempString= tempString + _selectedDays.elementAt(i) + ",";
}
var body1 = jsonEncode({
      'userName': UserName.text,
      'email': Email.text,
      'gender': Gendeer.text,
      'age': Age.text,
      'startWorkHoures': x.toString(),
      'endWorkHoures': y.toString(),
      "workingDays":tempString,
      "location":dropdownValue
    });

  var res = await http.post(Uri.parse(global.globall + "/trainer/sign-up"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body1);

        if (Gendeer.text.isNotEmpty &&
        UserName.text.isNotEmpty &&
        Email.text.isNotEmpty &&
        From.text.isNotEmpty &&
        Age.text.isNotEmpty &&
        To.text.isNotEmpty && _selectedDays.isNotEmpty) {
          if (!(Email.text.contains(RegExp(r'[@]')) &&
          Email.text.contains('.com'))) {
        _displayErrorMotionToast1();
        return null;
      }

      if(res.statusCode == 400) {
        if(res.body=="not unique email") {
          _displayErrorMotionToastEmail();
           return null;
        }

        else if(res.body == "not unique username") {
          _displayErrorMotionToastUser();
           return null;
        }

        else if(res.body == "invalid username") {
           _displayErrorMotionToastuserNameInvalid();
            return null;
        }
      }

      else if(res.statusCode == 200) {
        await createTrainerClasses();
         _selectedDays=[];
         return "done";
      }

        }

          else {
      _displayErrorMotionToast();
      return null;
    }

}

Future <void> createTrainerClasses() async {
String tempString="";
for(int i=0;i<_selectedDays.length;i++) {
tempString= tempString + _selectedDays.elementAt(i) + ",";
}
var body1 = jsonEncode({
      'username': UserName.text,
      "workingDays":tempString
    });

  var res = await http.post(Uri.parse(global.globall + "/trainer/fill-hours"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body1);

        if(res.statusCode == 200) {
          print('done');
        }
        else if(res.statusCode == 400) {
          print('error');
        }

}




}

