import 'package:flutter/material.dart';
import 'package:untitled/screens/Login.dart';

import 'Register.dart';

class Welcomescreen extends StatefulWidget {
  static String id="welcome";
  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 90.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: Image.asset("asset/img/message.jpg"),
            ),
            Text(
              "MessageMe",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 30,
            ),
            Material(
              elevation: 5,
              color: Colors.yellow[900],
              borderRadius: BorderRadius.circular(20),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, Login.id);

                },
                height: 42,
                minWidth: 200,
                child: Text("sign in"),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            
            Material(
              elevation: 5,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context,Register.id);
                },
                height: 42,
                minWidth: 200,
                child: Text(
                  "Register ",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ), // SizedBox(height:30 ,),
      ),
    );
  }
}

class mybutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
