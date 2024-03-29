//import 'package:chat_app/Authenticate/Methods.dart';
//import 'package:chat_app/Screens/ChatRoom.dart';
//import 'package:chat_app/group_chats/group_chat_screen.dart';
import './ChatRoom.dart';
import './FadeAnimation.dart';
import './MethodsChat.dart';
import './ChatSearch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  var name;
  HomeScreen(this.name);
  @override
  _ChatState createState() => _ChatState(name);
}

class _ChatState extends State<HomeScreen> {
  var name;
  _ChatState(this.name);
  Map<String, dynamic>? userMap;
  bool isLoading = false;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //late List contacts;
  var selectedService;
  var email;
  List contactList = [];
  @override
  /* void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }*/

  /*void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser?.uid).update({
      "status": status,
    });
  }
*/
  @override
  /*void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }*/

  /* Future Listusers() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var data =
        await _firestore.collection('users').doc(_auth.currentUser?.uid).get();

    setState(() {});
  }*/

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  Future<List> onshow() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var curent = FirebaseAuth.instance.currentUser?.email;
    await _firestore
        .collection('users')
        .where("email", isNotEqualTo: curent)
        .get()
        .then((value) {
      setState(() {
        contactList = [];
        for (int i = 0; i < value.docs.length; i++) {
          contactList.add(value.docs[i].data());
        }
      });
    });

    return contactList;
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
           backgroundColor: Color.fromARGB(255, 15, 105, 202),
          shadowColor:   Color(0xff81B2F5),
          title: const Center(
              child: Text('Chats',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))),
          actions: [
            Ink(
              decoration: const ShapeDecoration(
                //   color: Colors.lightBlue,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: const Icon(Icons.search_sharp),
                iconSize: 40,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
              ),
            ),
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => signOut(context))
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: FadeAnimation(
                  1,
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),

                   
                  ),
                ))
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<List>(
                  future: onshow(),
                  builder: (context, snapshot) {
                    //  print(snapshot.data);
                    if (snapshot.hasData) {
                      //print(snapshot.data);
                      var d = snapshot.data?.length;

                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 5.0,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: contactList.length,
                          itemBuilder: (context, index) {
                            return FadeAnimation(
                                (1.0 + index) / 4,
                                GestureDetector(
                                    onTap: () {
                                    
                                      setState(() {
                                        email = snapshot.data![index]['email'];
                                        List names = [name, email];
                                        names.sort();
                                        
                                          String roomId = chatRoomId(
                                                  // _auth.currentUser!.displayName!,
                                                  names[0],
                                                  names[1]);
                                             
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => ChatRoom(
                                                chatRoomId: roomId,
                                                userMap: snapshot.data![index],
                                              ),
                                            ),
                                          );

                                        if (selectedService == index)
                                          selectedService = -1;
                                        else
                                          selectedService = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: selectedService == index
                                            ? Colors.blue.shade50
                                            : Colors.grey.shade100,
                                        border: Border.all(
                                          color: selectedService == index
                                              ? const Color.fromARGB(
                                                  255, 0, 0, 0)
                                              : const Color.fromARGB(
                                                      255, 0, 0, 0)
                                                  .withOpacity(0),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                
                                                Text(
                                                  snapshot.data![index]['name']
                                                      .toString().split(" ")[0]+ " " +snapshot.data![index]['name']
                                                      .toString().split(" ")[3],
                                                  // .replaceAll(
                                                  //     '@gmail.com', ""),
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),

                                                   const SizedBox(
                                                  width: 50,
                                                ),
                                                const Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Icon(
                                                      Icons.chat,
                                                      size: 20,
                                                      color: Colors.black,
                                                    )),
                                               
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                /* Image.asset(
                                                  snapshot.data![
                                                          neededservices[index]]
                                                          ['Img']
                                                      .toString(),
                                                  width: 35,
                                                  height: 35,
                                                ),*/
                                                
                                              ]),
                                        ],
                                      ),
                                      // ignore: prefer_const_literals_to_create_immutables
                                    )));
                          });
                    } else {
                      return const Center(
                        child: Text(
                          'No chats',
                          textDirection: TextDirection.ltr,
                        ),
                      );
                    }
                  }),
            )));
  }
}
