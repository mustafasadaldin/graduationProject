import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_application_2/TrainerSittings/bottomBarTrainer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'dart:convert';
import 'dart:io' as file;
import 'HomePage.dart';
import 'Profile.dart';
import 'dart:io';
import '../global.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;
import 'package:path/path.dart' as Path;

class exerc extends StatefulWidget {
  @override
  State<exerc> createState() => _TDetailsState();
}

class _TDetailsState extends State<exerc> {

  var exercises = TextEditingController();
 final _textController = TextEditingController();
  final _textController2 = TextEditingController();
    var duration = TextEditingController();
    var Description = TextEditingController();
String imageTest="";
late  File imagepicker;
Future getImageFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
       imagepicker = File(image!.path);

 getFileImageString(imagepicker);
      // Upload(imagepicker);
    });
  }

  @override
  void initState() {
    super.initState();

    //  About = GetAbout();
  }

  Widget build(BuildContext context) {
  
 Future<void> _showDialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter a Descripion'),
            content: TextField(
              maxLines: 13,
              controller: Description,
              decoration: InputDecoration(hintText: 'Description'),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  // Do something with the user input
                  final input = _textController.text;
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
Future<void> _showDialog2(BuildContext context) async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter a URL'),
            content: TextField(
              maxLines: 3,
              controller: _textController2,
              decoration: InputDecoration(hintText: 'URL'),
            ),
                //contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 20), // set contentPadding to a larger value

            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  // Do something with the user input
                  final input2 = _textController2.text;
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        shadowColor: Colors.blue,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Settings'),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: global.imageTest!=""? MemoryImage(base64Decode(global.imageTest)):AssetImage('imagess/sport.png') as ImageProvider,
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.24,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffF9F9F9),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                      ),
                      // add your content here
                    ),
                  ],
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        getImageFromGallery();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller: exercises,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      color: Colors.blue,
                      Icons.fitness_center,
                    ),
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 4),
                      borderRadius:
                          BorderRadius.circular(20), // set the radius here
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 5),
                      borderRadius:
                          BorderRadius.circular(20), // set the radius here
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller: duration,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      color: Colors.blue,
                      Icons.hourglass_bottom,
                    ),
                    labelText: 'Duration',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 4),
                      borderRadius:
                          BorderRadius.circular(20), // set the radius here
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 5),
                      borderRadius:
                          BorderRadius.circular(20), // set the radius here
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.blue[200],
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Add Description click here',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(width: 50.0),
                      Tooltip(
                        message: 'Add item',
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.arrow_circle_right_outlined),
                          onPressed: ()=> _showDialog(context),
                        ),
                      )
                    ],
                  ),
                  
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.blue[200],
                  ),
                child:Row(
                   children: [
                      Text(
                        'Add URL click here',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(width: 104.0),
                      Tooltip(
                        message: 'Add item',
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.arrow_circle_right_outlined),
                          onPressed: ()=> _showDialog2(context),
                        ),
                      )
                    ],

                ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: 200.0,
                    height: 30,
                    child: MaterialButton(
                      onPressed: () async{
                          await Upload(imagepicker);

                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blue,
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
      description: Text('added'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }

  void _displayErrorMotionToast11() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Please fill in all feild'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }


  Future<String> getFileImageString(File file) async {
  Uint8List fileData = await file.readAsBytes();
  String base64Image = base64Encode(fileData);
  setState(() {
     imageTest=base64Image;
global.imageTest=imageTest;
  });
  return "data:image/png;base64,$base64Image";
}



  Future Upload(File imageFile) async {
    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();

    var uri = Uri.parse(global.globall + "/trianers/imageExercise");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('upload', stream, length,
        filename: Path.basename(imageFile.path));
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'token': global.token
    };
    request.headers["token"] = global.token;
    request.headers["Content-Type"] = 'application/json; charset=UTF-8';

    request.headers.addAll(headers);

    request.files.add(multipartFile);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {});
    await sendAllData();
  }

Future sendAllData() async{
  if((exercises.text.isEmpty) || (duration.text.isEmpty) || (Description.text.isEmpty) || (_textController2.text.isEmpty) || (imageTest == "")) {
    return _displayErrorMotionToast11();
  }
DateTime now = DateTime.now();
var body1 = jsonEncode({
'name':exercises.text,
'duration':duration.text,
'desc':Description.text,
'userName':global.userUserName,
'day':DateFormat('EEEE', 'en_US').format(now).trim(),
'url':_textController2.text
});

    
 var res = await http.post(Uri.parse(global.globall + "/trianers/Exercises"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token':global.token
            },
            body: body1);

            if(res.statusCode == 200) {
                setState(() {
                  Description.text="";
              duration.text="";
              exercises.text="";
            global.  imageTest="";
_displayErrorMotionToast1();
                });
              
                          }

            else if(res.statusCode == 400) {
              print('error');
            }

            else if(res.statusCode == 401) {
              print('not authenticated');
            }

}

}
