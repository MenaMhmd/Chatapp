import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Chat extends StatefulWidget {
  static String id = "chat";

  @override
  State<StatefulWidget> createState() => Myapp();
}

class Myapp extends State<Chat> {
  User? loggeruser;
  String collectionname = 'messages';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? messagetext;
  final _auth = FirebaseAuth.instance;
  bool spinner = false;
  final textfield = TextEditingController();

  void clear() {
    textfield.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(children: [
          Container(width: 30, child: Image.asset("asset/img/write.jpg")),
          Padding(
            padding: EdgeInsets.only(left: 17),
            child: Text(
              "Message Me",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ]),
        actions: [
          IconButton(
              onPressed: () {
                getmessage();
                // _auth.signOut();
              },
              icon: Icon(Icons.close)),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(

             // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: firestore.collection(collectionname).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        spinner = true;
                      }
                      spinner = false;
                      List<Material> addmessage = [];
                      final mess = snapshot.data!.docs;
                      for (var message in mess) {
                        final messagetext = message.get('message');
                        final messageemail = message.get('email');
                        final usermail = loggeruser?.email;
                        // final widgett=message( messtext: messageemail) ;
                        //Text('$messageemail',style: TextStyle(color: Colors.blue,fontSize: 15));
                        if (messageemail != usermail) {

                          Material tt = Material(
                              child: Text('$messageemail',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15)),
                             );
                          Material tt2 = Material(
                            elevation: 10,
                            shadowColor: Colors.grey,
                            borderRadius: BorderRadius.only(
                              topRight:Radius.circular(30) ,
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
                              child: Text('$messagetext',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 25)),
                            ),
                          );
                          addmessage.add(tt);
                          addmessage.add(tt2);
                        }
                        Material tt = Material(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$messageemail',
                                style:
                                    TextStyle(color: Colors.black, fontSize: 15)),
                          ),

                        );
                        Material tt2 = Material(
                          elevation: 10,
                          shadowColor: Colors.grey,
                          borderRadius: BorderRadius.only(
                            topLeft:Radius.circular(30) ,
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
                              child: Text('$messagetext',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25)),
                            ),
                         );
                        addmessage.add(tt);
                        addmessage.add(tt2);
                      }

                      return Expanded(
                        flex: 9,
                        child: ListView(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          children: addmessage,
                        ),
                      );
                    }),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              messagetext = value;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                hintText: "write your message",
                                border: InputBorder.none),
                            controller: textfield,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            firestore.collection(collectionname).add({
                              'message': messagetext,
                              'email': _auth.currentUser?.email
                            });
                            print("**************************");
                            print(_auth.currentUser?.email);
                            clear();
                          },
                          child: Text(
                            "Send",
                            style: TextStyle(

                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getmessage() async {
    //ديه طريقهfuture
    /*  var snapshot=await firestore.collection(collectionname).get();
    for(var message in snapshot.docs)
      {
      print("+++++++++++++++++");
      print(message);
      }*/

    //ديه طريقه stream
    var snapshotss = await firestore.collection(collectionname).snapshots();
    //كل docs جوهcollection
    await for (var snap in snapshotss) {
      //كل عنصر جوهdocs
      for (var s in snap.docs) {
        var dd = s.data();
        print("---------------------------------");
        for (var item in dd.keys) {
          print("---------------------------------");
          print(item);
        }
      }
    }
  }
}

class message extends StatelessWidget {
  final String messtext;
  message({required this.messtext});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.blue,
        child: Text('$messtext',
            style: TextStyle(color: Colors.white, fontSize: 15)));
  }
}
