import 'package:flutter/material.dart';
import 'package:flutter_application_2/settings/TrainerUserInfo.dart';
import 'package:flutter_application_2/settings/bottomBar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import '../global.dart';
import 'HomePage.dart';
class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List<String> _list = [];
  List<String> _imageList = [];
  List<String> _searchList = [];

  late Future image;
  late Future names;
  @override
  void initState() {
    super.initState();
    image=getTrainersImages();
    names=getTrainerNames();
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
      body: Waitforme()
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
                   global.trainerUsername=item;
                    Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: TrainerUserInfo(),
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
                            fontSize:25, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            );
        
  }));
}

Future getTrainersImages() async {

 if(global.selectedCity == "All") {
  var res= await http.get(Uri.parse(global.globall+"/trainers/get-imagesForSearch"),headers: {
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
 "location":global.selectedCity
});
var res= await http.post(Uri.parse(global.globall+"/trainers/get-imagesForSearchedLocation"),headers: {
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

Future getTrainerNames() async {
  if(global.selectedCity == "All") {
  var res= await http.get(Uri.parse(global.globall+"/trainers/usernamesForSearch"),headers: {
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
 "location":global.selectedCity
});
var res= await http.post(Uri.parse(global.globall+"/trainers/usernamesForSearchedLocation"),headers: {
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
