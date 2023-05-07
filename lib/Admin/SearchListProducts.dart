import 'dart:convert';
import 'package:flutter_application_2/Admin/HomePage.dart';
import 'package:flutter_application_2/Admin/ProductDetails.dart';
import 'package:flutter_application_2/Admin/UpdateProduct.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:page_transition/page_transition.dart';
import '../global.dart';
class SearchListProduct extends StatefulWidget {
  const SearchListProduct({Key? key}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchListProduct> {

  
  late Future allData;
  late Future image;

  List<String> _list = [
   
  ];
  List<String> _imageList = [
    
  ];
  List<String> _priceList = [
   
  ];
  List<String> _searchList = [];

  @override
  void initState() {
    super.initState();
      _searchList.addAll(_list);
     image=getProductsImages();
    allData=getProductsData();
  
   
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
       backgroundColor: Color.fromARGB(255, 15, 105, 202),
        shadowColor: Color(0xff81B2F5),
        title: Container(
          decoration: BoxDecoration(
              color: Colors.blue.shade200,
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
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                child: HomePage(),
                duration: Duration(milliseconds: 1000),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Waitforme()
    );
  }



Widget Waitforme() {
  
  return FutureBuilder( future: Future.wait([image,allData]), builder:((context, snapshot)  {

      return snapshot.data==null?  Center(child: CircularProgressIndicator()): 
         _searchList.length > 0
          ? ListView.builder(
              itemCount: _searchList.length + 1, // Add 1 for the header
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Header row
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: Text(
                        "Image",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Product Name",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            "Price",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Edit",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            "Delete",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                    ),
                  );
                } else {
                  // Data row
                  final item = _searchList[index - 1];
                  final image = _imageList[_list.indexOf(item)];
                  final price = _priceList[_list.indexOf(item)] + "\$";
                  return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                    backgroundImage: image!=""? MemoryImage(base64Decode(image)):AssetImage('imagess/profilePic.png') as ImageProvider,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item),
                            Text(price),
                          ],
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 16.0,
                          top: 8.0,
                          bottom: 8.0,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: IconButton(
                                onPressed: () {
                                  // Code to handle edit button pressed
                                  //print('Edit $index');
                                  global.adminProduct = _list.elementAt(index-1);
                                  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UpdateProduct()),
        );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: IconButton(
                                onPressed: () async{
                                  // Code to handle delete button pressed
                               
                                 await removeItem(_list.elementAt(index-1));
                               
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          global.productName=item;
                          Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                child: ProductDetails(),
                duration: Duration(milliseconds: 1000),
              ),
            );

                        },
                      ));
                }
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
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
      _imageList.add(arrayProducts[i]);
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
    for(int i=0; (i<arrayNames.length-1); i++) {
      _list.add(arrayNames[i]);
    }

     for(int i=0; (i<arrayPrices.length-1); i++) {
      _priceList.add(arrayPrices[i]);
    }

   
   _searchList.addAll(_list);
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
      description: Text('Deleted'),
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      width: 300,
      height: 100,
    ).show(context);
  }

Future removeItem(String item) async{
    
var body1 = jsonEncode({
'name':item,
});

    
 var res = await http.post(Uri.parse(global.globall + "/store/deleteProduct"),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token':global.token
            },
            body: body1);

            if(res.statusCode == 200) {
               Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchListProduct()),
        );
        return _displayErrorMotionToast1();
            }

            else if(res.statusCode == 400) {
              print('error');
            }

            else if(res.statusCode == 401) {
              print('not authenticated');
            }
  }
}
