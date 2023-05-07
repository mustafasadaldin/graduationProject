import 'dart:convert';
import 'dart:io' as Io;
import 'dart:typed_data';

import 'package:flutter_application_2/settings/MethodsChat.dart';
import 'package:flutter_application_2/settings/bottomBar.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../LOG.dart';
import '../sign_up.dart';
import 'Change_Password.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import '../global.dart';
import 'About.dart';
import 'Edit_Profile.dart';
import 'HomePage.dart';
import 'Profile.dart';

class Settings_Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Settings_PageState();
  }
}

class Settings_PageState extends State<Settings_Page> {
   late Future img;

   void initState(){
    super.initState();
    img=image2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.94),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Settings'),
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Waitforme(),
            Text(global.username, 
            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            ),
            SizedBox(height: 50.0),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      child: Edit_Profile(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                  },
                  icons: Icons.person,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.yellow,
                  ),
                  title: 'Edit Profile',
                  subtitle: "Set up your informtions",
                ),
              ],
            ),
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {
                    signOut(context).then((value) => {
                        logOut()
                    });
                    
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                  iconStyle: IconStyle(
                    backgroundColor: Colors.blue,
                  ),
                ),
                SettingsItem(
                  onTap: () {
                    Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      child: ChangePassword(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                  },
                  icons: Icons.repeat,
                  title: "Change password",
                  iconStyle: IconStyle(
                    backgroundColor: Colors.green,
                  ),
                ),
                SettingsItem(
                  iconStyle: IconStyle(
                    backgroundColor: Colors.red,
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                              title: Center(
                                child: Text("Confirm Deletion"),
                              ),
                              content: Container(
                                color: Color.fromARGB(255, 233, 241, 242),
                                height: 140,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        "Are you sure want to delete your account?",
                                        textAlign: TextAlign.center),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton.icon(
                                            icon: Icon(
                                              Icons.delete,
                                              size: 14,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.red),
                                            onPressed: () {
                                              deleteAcoount();
                                            }, //Delete
                                            label: Text("Delete")),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        ElevatedButton.icon(
                                            icon: Icon(
                                              Icons.close,
                                              size: 14,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.grey),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            label: Text("Cancel")),
                                      ],
                                    )
                                  ],
                                ),
                              ));
                        });
                  },
                  icons: Icons.delete_rounded,
                  title: "Delete account",
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
                ),
                radius: 90,
                backgroundImage: image1!=""? MemoryImage(base64Decode(image1)):AssetImage('imagess/profilePic.png') as ImageProvider,
              ),
            );

        
  }));
}





  void _displayErrorMotionToast1() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Good Bye'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }

  void _displayErrorMotionToast20() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('we look forward to see you again soon :('),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
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

  Future<void> logOut() async {
    var body1 = jsonEncode({'logout': 'user'});

    var res = await http.post(Uri.parse(global.globall + "/users/log-out"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': global.token
        },
        body: body1);

    if (res.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
      return _displayErrorMotionToast1();
    } else if (res.statusCode == 401) {
      return _displayErrorMotionToast3();
    }
  }

  Future<void> deleteAcoount() async {
    var body1 = jsonEncode({'delete': 'user'});

    var res = await http.post(Uri.parse(global.globall + "/users/deleteMe"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': global.token
        },
        body: body1);

    if (res.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Signup()),
      );
      return _displayErrorMotionToast20();
    } else if (res.statusCode == 401) {
      return _displayErrorMotionToast3();
    }
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


}
