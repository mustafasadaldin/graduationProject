import 'package:flutter/material.dart';
import 'package:flutter_application_2/settings/SearchTapBar.dart';
import 'package:flutter_application_2/settings/TrainerDetailsFromUser.dart';
import 'package:flutter_application_2/settings/calander.dart';
import 'package:flutter_application_2/settings/cartt.dart';
import 'package:flutter_application_2/sign_up.dart';
import 'Admin/SignupTrainer.dart';
import 'Forgotpassword.dart';
import 'LOG.dart';
import 'New-Text-Document-2 (1).dart';
import 'Resetpassword.dart';
import 'TrainerSittings/MyUsersProfile.dart';
import 'TrainerSittings/test.dart';
import 'TrainerSittings/uploadexercise.dart';
import 'home.dart';
import 'settings/Profile.dart';
import 'settings/TrainerBreaks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', //id
    'High Importance Notifications', //title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up : ${message.messageId}');
}

void main() async{
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };

  
WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'myApps',
    options: FirebaseOptions(
      apiKey: "XXX",
      appId: "XXX",
      messagingSenderId: "XXX",
      projectId: "XXX",
    ),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

   await  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  // constructor
  // build

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "NotoSerif",
        ),
        home: Login(),
        routes: {
          "login": (context) => Login(),
          "signup": (context) => Signup(),
          "ForgetPassword": (context) => ForgetPassword(),
          "homepage": (context) => Home_Screen(),
          "Resetpassword": (context) => ResetPassword(),
          "SignupTrainer": (context) => Signup_Trainer()
        });
  }
}
