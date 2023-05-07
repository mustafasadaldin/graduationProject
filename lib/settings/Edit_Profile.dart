// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/settings/MethodsChat.dart';
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
import 'package:path/path.dart' as Path;
import 'dart:io' as file;


class Edit_Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Edit_ProfileState();
  }
}

class Edit_ProfileState extends State<Edit_Profile> {
  var username = TextEditingController();
  var weight= TextEditingController();
  var height = TextEditingController();
  var age = TextEditingController();
  late file.File imagepicker;
  late Future upload = Upload(imagepicker);
  late Future img;
  Future getImageFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      final File imagepicker = File(image!.path);
      
                    Upload(imagepicker);

    });
  }

void initState(){
    super.initState();
    img=image2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
        title: Text('Edit Profile'),
        leading: IconButton(
          onPressed: () {
           Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: Settings_Page(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
          },
          icon: Icon(Icons.arrow_back),
        ),
       
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 50,
            ),
            Waitforme(),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    
                    child: Form(
                      child: Column(
                        
                        children: [
                          TextFormField(
                            controller: username,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81B2F5), width: 4),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color.fromARGB(255, 15, 105, 202), width: 5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: age,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Age',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81B2F5), width: 4),
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81B2F5), width: 5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color.fromARGB(255, 15, 105, 202), width: 5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: height,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Height',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81B2F5), width: 4),
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81B2F5), width: 5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color.fromARGB(255, 15, 105, 202), width: 5),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: weight,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Wieght',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81B2F5), width: 4),
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff81B2F5), width: 5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color.fromARGB(255, 15, 105, 202), width: 5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          cancelButton();
                        },
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      MaterialButton(
                        onPressed: () {
                          changeInfo();
                        },
                        color: Color.fromARGB(255, 15, 105, 202),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget Waitforme() {
  
  return FutureBuilder( future: img, builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
          Center(
              child: CircleAvatar(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () => getImageFromGallery(),
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 15, 105, 202),
                      radius: 25,
                      child: Icon(Icons.edit,color: Colors.white,),
                    ),
                  ),
                ),
                radius: 90,
                backgroundImage: image1!=""? MemoryImage(base64Decode(image1)):AssetImage('imagess/profilePic.png') as ImageProvider,
              ),
            );
 
  }));
}


void _displayErrorMotionToastuserNameInvalid(s) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(s),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }

void _displayErrorMotionToastUser(s) {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(s),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
    ).show(context);
  }

void _displayErrorMotionToast1(s) {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(s),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }
  Future Upload(File imageFile) async {    
  var stream  = new http.ByteStream(imageFile.openRead());
stream.cast();
      var length = await imageFile.length();

      var uri = Uri.parse(global.globall+"/users/image");

     var request = new http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile('upload', stream, length,
          filename: Path.basename(imageFile.path));
          Map<String, String> headers = {
             'Content-Type': 'application/json; charset=UTF-8',
            'token': global.token 
          };
                      request.headers["token"]=global.token;
                      request.headers["Content-Type"]='application/json; charset=UTF-8';


request.headers.addAll(headers);

      request.files.add(multipartFile);
      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
      });
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Edit_Profile()),
        );  

    }
var image1="";
    Future image2() async{
var body1 = jsonEncode({
  "email": global.email
});

var res= await http.post(Uri.parse(global.globall+"/users/image1"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',

  }, body: body1);

if(res.statusCode==200) {
  setState(() {
    image1 = res.body;
  });

}
return await image1;
  }

Future <void> changeInfo() async {

  if(username.text.isEmpty && age.text.isEmpty && height.text.isEmpty && weight.text.isEmpty) {
    return _displayErrorMotionToastuserNameInvalid("at least one field must be filled !");
  }
  if(username.text.isNotEmpty) {
    var body1 = jsonEncode({
  "username": username.text
});

var res =
        await http.post(Uri.parse(global.globall + "/users/info"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token': global.token
            },
            body: body1);

            
             if(res.statusCode == 400) {
              if(res.body == "invalid username") {
               return _displayErrorMotionToastuserNameInvalid("you must enter your full Quadruple name");
              }
              else if(res.body == "not unique username") {
               return _displayErrorMotionToastuserNameInvalid("This name is already used by other users!");
              }
            }
            changeData(context, username.text);
    global.username=username.text;
  }

  if(age.text.isNotEmpty) {
      var body1 = jsonEncode({
  "age": age.text
});

var res =
        await http.post(Uri.parse(global.globall + "/users/info"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token': global.token
            },
            body: body1);
            if(res.statusCode == 400) {
              return _displayErrorMotionToastuserNameInvalid("Error in changing age");
            }
      global.age=age.text.toString();
  }

  if(height.text.isNotEmpty) {
      var body1 = jsonEncode({
  "height": height.text
});

var res =
        await http.post(Uri.parse(global.globall + "/users/info"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token': global.token
            },
            body: body1);
            if(res.statusCode == 400) {
              return _displayErrorMotionToastuserNameInvalid("Error in changing height");
            }
    global.height=height.text.toString();
  }


  if(weight.text.isNotEmpty) {
      var body1 = jsonEncode({
  "weight": weight.text
});

var res =
        await http.post(Uri.parse(global.globall + "/users/info"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token': global.token
            },
            body: body1);
            if(res.statusCode == 400) {
              return _displayErrorMotionToastuserNameInvalid("Error in changing weight");
            }
      global.weight=weight.text.toString();
  }
  _displayErrorMotionToast1("changes done :)");
}

Future<void> cancelButton() async {

    username.text="";
    age.text="";
    height.text="";
    weight.text="";
}
}
