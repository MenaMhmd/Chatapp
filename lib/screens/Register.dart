import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';
import 'chat.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class Register extends StatefulWidget {
  static String id="register";
  @override
  State<StatefulWidget> createState() => Myapp();
}

class Myapp extends State<Register> {
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
   String name=" "; String email=" "; String password=" ";
bool spinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall:spinner ,
          child: Padding(
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
                    onChanged: (value){
                      name=value;
                    },
                    decoration: InputDecoration(
                        hintText: "name",
                        hintStyle: TextStyle(fontStyle: FontStyle.italic),
                        prefixIcon: Icon(Icons.woman),
                        enabledBorder: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.orange,width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue,width: 2))),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value){
                      email=value;
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
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value){
                      password=value;
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

                    color: Colors.yellow[900],
                    borderRadius: BorderRadius.circular(20),
                    child: MaterialButton(
                      onPressed: () async{
                        print("************");
                       // print(name);
                        setState(() {
                          spinner=true;
                        });

                        try {

                          final newuser = await _auth
                              .createUserWithEmailAndPassword(
                              email: email, password: password);
                          print(email);

                          setState(() {
                           // firestore.collection("").add("email":email)
                            spinner=false;
                          });
                          Navigator.pushNamed(context, Chat.id);
                        }catch(e)
                        {
                          print(e);
                        }
                      },
                      height: 42,
                      minWidth: 200,
                      child: Text("Sign Up"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text("Already have an account?",),
                        GestureDetector(child: Text("Login",style: TextStyle(color: Colors.blue),),onTap: (){Navigator.pushNamed(context, Login.id);},)
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }
}
