import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/settings/store.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
import '../global.dart';
import 'package:http/http.dart' as http;

import 'package:razorpay_flutter/razorpay_flutter.dart';


import 'dart:async';



class CartBar extends StatefulWidget {
  @override
  State<CartBar> createState() => _cartbarState();
}

class _cartbarState extends State<CartBar> {
  double price=0;
  late   var _razorpay;
  var amountController = TextEditingController();

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    // Do something when payment succeeds
    await buy();
    print("Payment Done");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  @override
  void initState() {
    super.initState();
    setState(() {
       for(int i=0; i<global.productPriceList.length;i++){
      price+=global.productPriceList[i];
    }
    });
     _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
   
  }

  Future <void> callPaymentApi() async{
     var options = {
                    'key': "rzp_test_xzYxlJyA9lwukq",
                    // amount will be multiple of 100c
                    'amount':  100
                        .toString(), //So its pay 500
                    'name': 'Code With Patel',
                    'currency':"USD",
                    'description': 'Demo',
                    'timeout': 300, // in seconds
                    'prefill': {
                      'contact': '8787878787',
                      'email': 'codewithpatel@gmail.com'
                    }
                  };
                  _razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '',
                  style: TextStyle(
                      color: Color(0xFF4C53A5),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Total Price : "+price.toString()+ " \$",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 63, 78, 234),
                  ),
                )
              ],
            ),
            Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 64, 79, 239),
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async{
                      await callPaymentApi();
                  },
                  child: Text(
                    'Check Out',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }


  void _displayErrorMotionToast2() {
    MotionToast.success(
      title: Text(
        'Success',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text('Thank you :)'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }
  Future buy() async {
    var flag=true;
    for(int i=0; i<global.productNameList.length;i++) {
      var body1 = jsonEncode({
      'name': global.productNameList[i],
      'amount': global.productamountList[i],
    });

    var res = await http.post(Uri.parse(global.globall + "/store/buyProduct"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token':global.token
        },
        body: body1);

        if(res.statusCode == 200) {
          flag=true;
        }

        else if(res.statusCode == 400) {
          print('error');
          flag=false;
        }

        else if(res.statusCode == 401) {
          print('not authenticated');
          flag=false;
        }
    }

  if(flag){
    global.productNameList=[];
          global.productPriceList=[];
          global.productamountList=[];
          global.productImageList=[];
          Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      child: Storee(),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                  return  _displayErrorMotionToast2();
  }
     
  }

}
