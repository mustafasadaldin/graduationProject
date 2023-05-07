import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_application_2/Admin/HomePage.dart';
import 'package:flutter_application_2/Admin/SearchListProducts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';


import 'package:image_picker/image_picker.dart';

import 'dart:io';
import '../global.dart';


import 'dart:io';
import '../global.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;
import 'package:path/path.dart' as Path;

class UpdateProduct extends StatefulWidget {
  @override
  State<UpdateProduct> createState() => _TDetailsState();
}

class _TDetailsState extends State<UpdateProduct> {
 var name = TextEditingController();
        var amount = TextEditingController();

    var price = TextEditingController();
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
  global.imageTest="";
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
          backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
          title: Text('Update Product'),
          leading: IconButton(
          onPressed: () {
           Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: SearchListProduct(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
          },
          icon: Icon(Icons.arrow_back),
        ),
        ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 5,
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
                      height: 15,
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
                  controller: name,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      color: Colors.blue,
                      CupertinoIcons.cart,
                    ),
                    labelText: 'Name of Product',
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
                  controller: amount,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      color: Colors.blue,
                      Icons.storefront_outlined,
                    ),
                    labelText: 'Amount',
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
                  controller: price,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      color: Colors.blue,
                      Icons.price_check,
                    ),
                    labelText: 'Price',
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
                          onPressed: () => _showDialog(context),
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
                          await sendAllData();
                      },
                      child: const Text(
                        'Update a Product',
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
      description: Text('updated'),
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
      description: Text('Please fill in aone field at least'),
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

    var uri = Uri.parse(global.globall + "/store/UpdateproductImageAdmin?name="+global.adminProduct);

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
    

  }



  
Future sendAllData() async{

  var flag= false;
    if(imageTest != "") {
      flag=true;
      await Upload(imagepicker);
    }

    if(!name.text.isEmpty) {
      flag=true;
      var body1 = jsonEncode({
'name':global.adminProduct,
'pName':name.text,
});

var res = await http.post(Uri.parse(global.globall + "/admin/updateProductFromAdmin"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token':global.token
            },
            body: body1);

            if(res.statusCode == 200) {
                setState(() {
                  global.adminProduct=name.text.trim();
              name.text="";
                });
                          }

            else if(res.statusCode == 400) {
              print('error');
            }

            else if(res.statusCode == 401) {
              print('not authenticated');
            }
    }


    if(!Description.text.isEmpty) {
      flag=true;
      var body1 = jsonEncode({
'name':global.adminProduct,
'desc':Description.text,
});

var res = await http.post(Uri.parse(global.globall + "/admin/updateProductFromAdmin"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token':global.token
            },
            body: body1);

            if(res.statusCode == 200) {
                setState(() {
              Description.text="";
                });
                          }

            else if(res.statusCode == 400) {
              print('error');
            }

            else if(res.statusCode == 401) {
              print('not authenticated');
            }
    }
 

  if(!amount.text.isEmpty) {
    flag=true;
      var body1 = jsonEncode({
'name':global.adminProduct,
'amount':int.parse(amount.text),
});

var res = await http.post(Uri.parse(global.globall + "/admin/updateProductFromAdmin"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token':global.token
            },
            body: body1);

            if(res.statusCode == 200) {
                setState(() {
              amount.text="";
                });
                          }

            else if(res.statusCode == 400) {
              print('error');
            }

            else if(res.statusCode == 401) {
              print('not authenticated');
            }
    }

    if(!price.text.isEmpty) {
      flag=true;
      var body1 = jsonEncode({
'name':global.adminProduct,
'price':int.parse(price.text),
});

var res = await http.post(Uri.parse(global.globall + "/admin/updateProductFromAdmin"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token':global.token
            },
            body: body1);

            if(res.statusCode == 200) {
                setState(() {
              price.text="";
                });
                          }

            else if(res.statusCode == 400) {
              print('error');
            }

            else if(res.statusCode == 401) {
              print('not authenticated');
            }
    }
    if(flag)
    _displayErrorMotionToast1();
    else if(!flag)
    _displayErrorMotionToast11();

}

}
