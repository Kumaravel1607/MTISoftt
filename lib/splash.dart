import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google/Constant/color.dart';
import 'package:google/Navigation.dart';
import 'package:google/Student_login.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () async {
      SharedPreferences session = await SharedPreferences.getInstance();
      var email = session.getString('email');
      // var mobile = session.getString('phone');
      // var token = session.getString('token');
      print("-------");
      print(email);
      if (email == null || email == "") {
        // if (token != null) {

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Student_login()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Navigation()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/school.jpeg',
                height: 100,
                width: 150,
              ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   "My Leave Reports",
              //   style: TextStyle(
              //       color: Blue,
              //       fontSize: 25,
              //       fontStyle: FontStyle.italic,
              //       fontWeight: FontWeight.w500),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // CircularProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              //   backgroundColor: Colors.white,
              //   strokeWidth: 2,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
