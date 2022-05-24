import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/Register.dart';

import 'chat.dart';

class Login extends StatefulWidget {
  static String id="login";
  @override
  State<StatefulWidget> createState() => Myapp();
}

class Myapp extends State<Login> {
  User? user;
  void getcurrentuser()
  {
    final loggeduser= _auth.currentUser;
    if(loggeduser!=user)
    {
      user=loggeduser!;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentuser();
  }
  final _auth=FirebaseAuth.instance;
   String email=" "; String password=" ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 30.0,right: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  child: Image.asset("asset/img/message.jpg"),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  textAlign: TextAlign.center,
                  onSaved: (value){
                    email=value!;
                  },
                  decoration: InputDecoration(
                      hintText: "email",
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      prefixIcon: Icon(Icons.email),
                      enabledBorder: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.orange,width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blue,width: 2))),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  textAlign: TextAlign.center,
                  onSaved: (value){
                    password=value!;
                  },

                  decoration: InputDecoration(
                      hintText: "password",
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      prefixIcon: Icon(Icons.password),

                      enabledBorder: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(20),

                          borderSide: BorderSide(color: Colors.orange,width: 1)),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blue,width: 2))),
                ),
                SizedBox(height: 10,),
                Material(
                  elevation: 5,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    onPressed: () {
                      try {
                        _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        Navigator.pushNamed(context, Chat.id);
                      }
                      catch(e)
                      {
                        print(e);
                      }

                    },
                    height: 42,
                    minWidth: 200,
                    child: Text("Login"),
                  ),

                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text("Don't have an account?",),
                    GestureDetector(child: Text("Register",style: TextStyle(color: Colors.blue),),onTap: (){Navigator.pushNamed(context, Register.id);},)
                  ],
                ),
              ]),
        ));
  }
}