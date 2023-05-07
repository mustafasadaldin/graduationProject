import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_2/settings/ShowMyPrograme.dart';
import 'package:page_transition/page_transition.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../settings/Settings_Page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global.dart';


class videooo extends StatefulWidget {
  
  final String desc;

  const videooo({Key? key, required this.desc}) : super(key: key);

  @override
  State<videooo> createState() => _MyWidgetState();

  
}

class _MyWidgetState extends State<videooo> {
  var url="";
  var desc="";
  late YoutubePlayerController _controller;
  @override
  void initState() {
    
    final videoID = YoutubePlayer.convertUrlToId(global.url);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        
      ),
    );


    super.initState();
    // allData=getExe();
  }

  @override
  void dispose() {
    _controller.pause(); // pause the video before disposing
    _controller.dispose(); // dispose the controller to free up resources
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 105, 202),
        shadowColor: Color(0xff81B2F5),
        title: Text('Exercise description'),
        leading: IconButton(
          onPressed: () {
          
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                child: ShowExercises(),
                duration: Duration(milliseconds: 1000),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
  children: [
    YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        global.desc,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
),

    );
  }
}

