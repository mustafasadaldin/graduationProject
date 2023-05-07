import 'dart:convert';
import 'package:flutter_application_2/Admin/UploadProduct.dart';
import 'package:flutter_application_2/settings/ChatHomeScreen.dart';
import 'package:flutter_application_2/settings/MethodsChat.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_2/global.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import '../global.dart';
import '../LOG.dart';
import 'SignupTrainer.dart';
import 'changePaswwordAdmin.dart';

class NavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavBarState();
  }
}

class NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Mustafa Saad Al Deen',style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: 20)),
            accountEmail: Text("mustafa001063@gmail.com",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: 20)),
            currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 15, 105, 202),
                  child: Text("M"),
                ),
            decoration: BoxDecoration(
                  color: Colors.black12,
                  image: DecorationImage(
                      image: AssetImage(
                          'imagess/test.png'),
                      fit: BoxFit.cover),
                ),
          ),
          
          ListTile(
            title: Text(
              "Change Password",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
            ),
            leading: Icon(
              Icons.vpn_key,
              color: Colors.green,
            ),
            onTap: () {
             Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeftJoined,
                  child: changePasswordAdmin(),
                  childCurrent: NavBar(),
                  duration: Duration(milliseconds: 1000),
                ),
              );
            },
          ),

          SizedBox(
            height: 10.0,
          ),
          ListTile(
                title: Text(
                  "Chat",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
                ),
                subtitle: Text("Help users"),
                leading: Icon(
                  Icons.chat,
                  color: Colors.green,
                ),
                onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen(global.email)));
                },
              ),
          SizedBox(
            height: 10.0,
          ),
          ListTile(
            title: Text(
              "About",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
            ),
            leading: Icon(
              Icons.help,
              color: Colors.orange,
            ),
            onTap: () {
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          ListTile(
            title: Text(
              "Logout",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
            ),
            leading: Icon(
              Icons.exit_to_app_outlined,
              color: Colors.black,
            ),
            onTap: () {
             signOut(context).then((value) => {
                        logOut()
                    });
            },
          ),
        ],
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
      description: Text('Good Bye'),
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

  var body1 = jsonEncode({
  'logout':'admin'
     });
              
    var res= await http.post(Uri.parse(global.globall+"/admin/log-out"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token': global.token 
  },body: body1);

  if(res.statusCode == 200) {
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
              return _displayErrorMotionToast1();
  }

  else if(res.statusCode == 401) {
    return _displayErrorMotionToast3();
  }

  }


}
