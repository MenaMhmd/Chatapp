import 'package:flutter/material.dart';
import 'package:untitled/screens/Login.dart';
import 'package:untitled/screens/Register.dart';
import 'package:untitled/screens/chat.dart';
import 'package:untitled/screens/welcomescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Welcomescreen.id,
      routes: {
        Welcomescreen.id:(context)=>Welcomescreen(),
        Login.id:(context)=>Login(),
        Register.id:(context)=>Register(),
        Chat.id:(context)=>Chat(),
      },
      home: Chat(),
    );
  }

}
