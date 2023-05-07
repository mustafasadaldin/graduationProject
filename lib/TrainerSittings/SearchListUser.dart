import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/TrainerSittings/Settings_Page.dart';
import 'package:flutter_application_2/TrainerSittings/bottomBarTrainer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import '../global.dart';
import 'HomePage.dart';
import 'Profile.dart';
import 'ShowSearchedUserProfile.dart';
class SearchListUser extends StatefulWidget {
  const SearchListUser({Key? key}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchListUser> {
  List<String> _list = [];
  List<String> _imageList = [];
  List<String> _searchList = [];

  late Future image;
  late Future names;

  int _selectedIndex = 0;

  final List<Widget> _pages = [
     HomePage_trianer(),
     SearchListUser(),
     Settings_Page(),
     ProfileTrainer(),
  ];
  @override
  void initState() {
    super.initState();
    image=getUsersImages();
    names=getUsersNames();
   // _searchList.addAll(_list);
  }

  void _filterList(String searchTerm) {
    setState(() {
      _searchList = _list
          .where(
              (item) => item.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
        title: Container(
          decoration: BoxDecoration(
              color: Color(0xff81B2F5),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Search here',
                      contentPadding: EdgeInsets.all(8)),
                  onChanged: (searchTerm) => _filterList(searchTerm),
                ),
              ),
              IconButton(
                onPressed: () {
                  _filterList('');
                },
                icon: Icon(Icons.cancel),
              )
            ],
          ),
        ),

       
      ),
      body: Waitforme(),
      
     
    );
  }

Widget Waitforme() {
  
  return FutureBuilder( future: Future.wait([image,names]), builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
         
         _searchList.length > 0
          ? ListView.builder(
              itemCount: _searchList.length,
              itemBuilder: (context, index) {
                final item = _searchList[index];
                final image = _imageList[_list.indexOf(item)];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: image!=""? MemoryImage(base64Decode(image)):AssetImage('imagess/profilePic.png') as ImageProvider,
                  ),
                  title: Text(item),
                  contentPadding:
                      EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                  onTap: () {
                    global.userUserName=item;
                    Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: ShowSearchedUserProfile(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                  
                  },
                );
              },
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search_off,
                        size: 120,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'No results found,\nPlease try different keyword',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            );
        
  }));
}

Future getUsersImages() async {
  if(global.selectedCityT == "All") {
  var res= await http.get(Uri.parse(global.globall+"/trainers/get-users-imagesForSearch"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  });

  if(res.statusCode == 200) {
    Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['str'];
    var arrayTrainers = array.split(",");
   int trainersCount12=arrayTrainers.length-1;
    for(int i=0; i<trainersCount12; i++) {
      
      _imageList.add(arrayTrainers[i]);
    }
    return await [_imageList];
  }
  else if(res.statusCode == 401) {
    print("not authenticated");
    return null;
  }

  else if(res.statusCode == 400) {
    print('errorImages');
    return null;
  }
  }

  else {
    var body1 = jsonEncode({
 "location":global.selectedCityT
});
    var res= await http.post(Uri.parse(global.globall+"/trainers/get-users-imagesForSearchedLoc"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  }, body: body1);

  if(res.statusCode == 200) {
    Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['str'];
    var arrayTrainers = array.split(",");
   int trainersCount12=arrayTrainers.length-1;
    for(int i=0; i<trainersCount12; i++) {
      
      _imageList.add(arrayTrainers[i]);
    }
    return await [_imageList];
  }
  else if(res.statusCode == 401) {
    print("not authenticated");
    return null;
  }

  else if(res.statusCode == 400) {
    print('errorImages');
    return null;
  }
  }
}

Future getUsersNames() async {
  if(global.selectedCityT == "All") {
  var res= await http.get(Uri.parse(global.globall+"/trainers/users-usernamesForSearch"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  });
  if(res.statusCode == 200) {
     Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['str'];
    var arrayTrainers = array.split(",");
   int trainersCount=arrayTrainers.length-1;
    for(int i=0; i<trainersCount; i++) {
      _list.add(arrayTrainers[i]);
    }
    _searchList.addAll(_list);
    return await [_list];
  }
  else if(res.statusCode == 401) {
    print("not authenticated");
    return null;
  }

  else if(res.statusCode == 400) {
    print('errorNames');
    return null;
  }
  }

  else {
var body1 = jsonEncode({
 "location":global.selectedCityT
});
    var res= await http.post(Uri.parse(global.globall+"/trainers/users-usernamesForSearchedLoc"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  }, body: body1);
  if(res.statusCode == 200) {
     Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['str'];
    var arrayTrainers = array.split(",");
   int trainersCount=arrayTrainers.length-1;
    for(int i=0; i<trainersCount; i++) {
      _list.add(arrayTrainers[i]);
    }
    _searchList.addAll(_list);
    return await [_list];
  }
  else if(res.statusCode == 401) {
    print("not authenticated");
    return null;
  }

  else if(res.statusCode == 400) {
    print('errorNames');
    return null;
  }
  }
}

}
