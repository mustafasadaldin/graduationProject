import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_2/settings/ShopCartBar.dart';
import 'package:flutter_application_2/settings/showProductInfo.dart';
import 'package:flutter_application_2/settings/store.dart';
import 'package:page_transition/page_transition.dart';
import '../global.dart';
class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CheckOut> {

  
  List items = [];

  List prices = [];

  List quantities = [];

  void removeItem(int index) {
    setState(() {
      global.productImageList.removeAt(index);
      global.productNameList.removeAt(index);
      global.productamountList.removeAt(index);
      global.productPriceList.removeAt(index);
      items=global.productNameList;
      prices=global.productPriceList;
      quantities=global.productamountList;
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CheckOut()),
        );
    });
  }
   
@override
  void initState() {
    super.initState();
    items=global.productNameList;
    prices=global.productPriceList;
    quantities=global.productamountList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('My Shopping Bag', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        ),
        leading: IconButton(
          onPressed: () {
           Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: Storee(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
          },
          icon: Icon(Icons.arrow_back),
        ),

      ),
      
      body:
       Padding(
         padding: const EdgeInsets.only(top: 20),
         child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                 global.productName=items.elementAt(index);
                 int tempIndex=global.tempProductNames.indexOf(global.productName);
              global.productPrice=global.tempProductPrices.elementAt(tempIndex);
              global.productImage=global.productImageList.elementAt(index);
              global.productAmount=global.tempProductAmounts.elementAt(tempIndex);
                 Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: showProductInfo(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
              },
              child: Container(
                height: 110,
                width: 50,
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          offset: Offset(5, 5))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 50,
                      margin: const EdgeInsets.only(right: 15),
                       decoration: BoxDecoration(
                       image: DecorationImage(image:MemoryImage(base64Decode("${global.productImageList[index]}")))
                       ) ,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            items[index],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            '\$${prices[index]}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              removeItem(index);
                            },
                            icon: Icon(
                              Icons.dangerous,
                              color: Colors.red,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "${quantities[index]}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
             ),
       ),
      bottomNavigationBar: CartBar(),
    );
  }
}
