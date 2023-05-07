import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_application_2/settings/store.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../global.dart';
import 'Subscribtion.dart';
import 'TrainerUserInfo.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class showProductInfo extends StatefulWidget {
  showProductInfo();

  @override
  State<showProductInfo> createState() => _CookieDetailState();
}

class _CookieDetailState extends State<showProductInfo> {
  var image, price, name, desc,amount, count, temp;
  late Future getDesc;
  var flag = true;
   var ratingValue=0.0;
   late Future avgRating;
  @override
  void initState() {
    count=0;
    price=int.parse(global.productPrice);
    temp=price;
    amount=0;
    super.initState();
    getDesc=getProductsInfo();
    avgRating = getAvgRatingVal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
          Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: Storee(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
          },
        ),
        title: Text('Pickup',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Colors.white)),
      ),
      body: ListView(children: [
        SizedBox(height: 15.0),
        Padding(
          padding: EdgeInsets.only(left: 115.0),
          child: Text(global.productName,
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 42.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        SizedBox(height: 15.0),
        CircleAvatar(
            child: Align(
              alignment: Alignment.bottomRight,
            ),
            radius: 90,
            backgroundImage:  MemoryImage(base64Decode(global.productImage)),
          ),
 SizedBox(height: 5.0),
          Waitforme2(),
        SizedBox(height: 20.0),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.attach_money_rounded,
          ),
          Text(price.toString(),
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              )),
        ]),
        SizedBox(height: 10.0),
        Center(
          child: Text('In stock: ' + global.productAmount + ' items',
              style: TextStyle(
                  color: Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 24.0)),
        ),
        SizedBox(height: 20.0),
       Waitforme(),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: 'minus',
              mini: true,
              onPressed: () {
                setState(() {
               
                      if(count>0)
                      count--;
                      if(count>0)
                    price = temp*count;
                  
                  
                });
              },
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Text(count.toString(),
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
            SizedBox(
              width: 40,
            ),
            FloatingActionButton(
              heroTag: 'plus',
              mini: true,
              backgroundColor: Colors.blue,
              onPressed: () {
                setState(() {
             
                    count++;
                    price = temp*count;
                    
                  
                });
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Center(
            child: InkWell(
              onTap:() async {
                if(!global.productNameList.contains(global.productName)){
                  await checkAmount(global.productName, count);
                  if(flag){
                    if(count!=0){
                global.productNameList.add(global.productName);
                global.productImageList.add(global.productImage);
                global.productPriceList.add(price);
                global.productamountList.add(count);
                _displayErrorMotionToast1();
                    } else {
                      _displayErrorMotionToast20();
                    }
                  }
                  else {
                      _displayErrorMotionToast10();
                  }
                } else {
                   await checkAmount(global.productName, count);
                  if(flag){
                    if(count!=0){
                  int tempIndex=global.productNameList.indexOf(global.productName);
                  global.productPriceList[tempIndex]=price;
                  global.productamountList[tempIndex]=count;
                  _displayErrorMotionToast2();
                    } else {
                      _displayErrorMotionToast20();
                    }
                  } else {
                    _displayErrorMotionToast10();
                  }
                }
              } ,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.blue),
                  child: Center(
                      child: Text(
                    'Add to cart',
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ))),
            ))
      ]),
    );
  }


Widget Waitforme() {
  
  return FutureBuilder( future: getDesc, builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
         
 Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    color: Color(0xFFB4B8B9))),
          ),
        );
        
  }));
}



Widget Waitforme2() {
  
  return FutureBuilder( future: avgRating, builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
         
  Center(
                    child: SmoothStarRating(
                      starCount: 5,
                      rating: ratingValue,
                      onRated: (v) {
                        setState(() {
                          print(v);
                        });
                       setStarRate(v);
                      },
                      allowHalfRating: true,
                      color: Color.fromARGB(255, 255, 191, 52),
                      borderColor: Color.fromARGB(255, 255, 191, 52),
                    ),
           
                  );
        
  }));
}



  Future getProductsInfo() async {
     var body1 = jsonEncode({'name': global.productName});

    var res =
        await http.post(Uri.parse(global.globall + "/store/productDesc"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token': global.token
            },
            body: body1);
  
  if(res.statusCode == 200) {
     Map<String, dynamic> DB = jsonDecode(res.body);
    desc=DB['desc'];
   print(desc);
    return await DB;
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

 void _displayErrorMotionToast1() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('added to cart :)'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }


void _displayErrorMotionToast10() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('This amount is not available in stock :('),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }

  void _displayErrorMotionToast20() {
    MotionToast.error(
      title: Text(
        'Error',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('You should select at least one item !'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }


  void _displayErrorMotionToast2() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Modified :)'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }


  Future checkAmount(var name, var amount) async {
     var body1 = jsonEncode({
      'name': name,
      'amount': amount,
    });

    var res = await http.post(Uri.parse(global.globall + "/store/checkProductAmount"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token':global.token
        },
        body: body1);
        if(res.statusCode == 200) {
          if(res.body == "No") {
            flag=false;
          }
          else if(res.body == "ok") {
            flag=true;
          }
        }

        else if (res.statusCode == 400) {
          print('error');
        }

        else if (res.statusCode == 401) {
          print('not authenticated');
        }
  }

  
Future<void> setStarRate(var value) async {
var body1 = jsonEncode({
  "name": global.productName,
  "numberOfStars":value
});

var res= await http.post(Uri.parse(global.globall+"/store/setProdRate"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

  if(res.statusCode == 200) {

    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => showProductInfo())
        );
  }

  else if(res.statusCode == 400) {
 print('error');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }


}


Future getAvgRatingVal() async {
var body1 = jsonEncode({
  "name": global.productName,
});

var res= await http.post(Uri.parse(global.globall+"/store/getProductRating"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token':global.token

  }, body: body1);

  if(res.statusCode == 200) {
    print(res.body);
    ratingValue = double.parse(res.body);
    return await ratingValue;
  }

  else if(res.statusCode == 400) {

 print('error');
 }

 else if(res.statusCode == 401) {
  print('not authenticated');
 }
}
}
