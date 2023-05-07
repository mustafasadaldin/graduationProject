import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_application_2/Admin/SearchListProducts.dart';
import 'package:flutter_application_2/settings/store.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../global.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails();

  @override
  State<ProductDetails> createState() => _CookieDetailState();
}

class _CookieDetailState extends State<ProductDetails> {
  var image, price, name, desc,amount;
  late Future getDesc;
  var flag = true;
   var ratingValue=0.0;
   late Future avgRating;
  @override
  void initState() {
    
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
                      child: SearchListProduct(),
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
      body: Waitforme(),
    );
  }


Widget Waitforme() {
  
  return FutureBuilder( future: getDesc, builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
          ListView(children: [
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
            backgroundImage:  MemoryImage(base64Decode(image)),
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
          child: Text('In stock: ' + amount + ' items',
              style: TextStyle(
                  color: Color(0xFF575E67),
                  fontFamily: 'Varela',
                  fontSize: 24.0)),
        ),
        SizedBox(height: 20.0),
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
        ),
        
      ]);

        
  }));
}



Widget Waitforme2() {
  
  return FutureBuilder( future: avgRating, builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
         
  Center(
                    child: SmoothStarRating(
                      starCount: 5,
                      rating: ratingValue,
                      isReadOnly: true,
                      onRated: (v) {
                        setState(() {
                          print(v);
                        });
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
        await http.post(Uri.parse(global.globall + "/store/getProdInfoAdmin"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token': global.token
            },
            body: body1);
  
  if(res.statusCode == 200) {
     Map<String, dynamic> DB = jsonDecode(res.body);
    desc=DB['desc'];
    price=DB['price'];
    amount=DB['amount'];
    image=DB['image'];
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
