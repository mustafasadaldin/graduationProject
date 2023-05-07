import 'package:flutter/material.dart';
import 'package:flutter_application_2/TrainerSittings/bottomBarTrainer.dart';
import 'package:flutter_application_2/settings/ShopCart.dart';
import 'package:flutter_application_2/settings/bottomBar.dart';
import 'package:flutter_application_2/settings/showProductInfo.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import 'HomePage.dart';

import 'dart:convert';
import 'package:flutter_application_2/global.dart';
import 'package:http/http.dart' as http;

class Storee extends StatefulWidget {
  const Storee({Key? key}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<Storee> {
  List names=[];
  List images=[];
  List prices=[];
  List Amounts=[];
  late Future allData;
  late Future image;
  Color iconColor=Colors.black;
 var isFavorite=false;
  @override
  void initState() {
    super.initState();
    image=getProductsImages();
    allData=getProductsData();
    //centreProducts = getCentreProducts(centreName: widget.centreName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: global.logged=='user'? bottom_bar():bottom_barTrainer(),
                    duration: Duration(milliseconds: 500),
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            'Products',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: CheckOut(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                },
                icon: Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                )),
          ],
        ),
        body: Waitforme()
      ),
    );
  }

  Widget _buildCard(String Name, String price, MemoryImage imgPath,
      String description, bool added, bool isFavorite, context,  VoidCallback onTap) {
        
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
      child: InkWell(
        onTap:onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                spreadRadius: 3,
                blurRadius: 5,
              )
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
             Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                 
                ),
              ),

              Hero(
                  tag: imgPath,
                  child: Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: imgPath,
                      fit: BoxFit.cover,
                    )),
                  )),
              SizedBox(
                height: 7,
              ),
              Text(
                price,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              Text(
                Name,
                style: TextStyle(color: Color(0xFFD17E50), fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  color: Color(0xFFEBEBEB),
                  height: 1.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 2),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  if (!added) ...[
                    InkWell(
                      onTap: onTap,
                      child: Row(
                        children: [
                          Icon(Icons.shopping_basket,
                              color: Color(0xFFD17E50), size: 16.0),
                          SizedBox(width: 5.0),
                          Text(
                            'Add to cart',
                            style: TextStyle(
                                fontFamily: 'Varela',
                                color: Color(0xFFD17E50),
                                fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }



Widget Waitforme() {
  
  return FutureBuilder( future: Future.wait([allData, image]), builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
         
         ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(right: 15),
              width: MediaQuery.of(context).size.width - 30,
              height: MediaQuery.of(context).size.height - 50,
              child: GridView.builder(
                itemCount: names.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  childAspectRatio: .8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return _buildCard("${names[index]}", "\$"+"${prices[index]}", MemoryImage(base64Decode("${images[index]}")) ,
                      "shshhs", false, false, context, () {
   
         global.productName=names.elementAt(index);
              global.productPrice=prices.elementAt(index);
              global.productImage=images.elementAt(index);
              global.productAmount=Amounts.elementAt(index);
                 Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: showProductInfo(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
  
    },);
                },
              ),
            )
          ],
        );
      
        
  }));

}


Future getProductsImages() async {

  var res= await http.get(Uri.parse(global.globall+"/store/allProducts"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  });

  if(res.statusCode == 200) {
    Map<String, dynamic> DB = jsonDecode(res.body);
     var array=DB['strImage'];
    var arrayProducts = array.split(",");

    for(int i=0; (i<arrayProducts.length-1); i++) {
      images.add(arrayProducts[i]);
    }
    return await DB;
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

Future getProductsData() async {
  var res= await http.get(Uri.parse(global.globall+"/store/allProductsData"),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
                  'token':global.token 
  });
  if(res.statusCode == 200) {
     Map<String, dynamic> DB = jsonDecode(res.body);
     var arrayNames=DB['names'].split(',');
     var arrayPrices=DB['prices'].split(',');
     var arrayAmount =DB['amount'].split(',');
    for(int i=0; (i<arrayNames.length-1); i++) {
      names.add(arrayNames[i]);
    }

     for(int i=0; (i<arrayPrices.length-1); i++) {
      prices.add(arrayPrices[i]);
    }

    for(int i=0; (i<arrayAmount.length-1); i++) {
      Amounts.add(arrayAmount[i]);
    }
    
    global.tempProductNames=names;
    global.tempProductPrices=prices;
    global.tempProductAmounts=Amounts;
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


}
