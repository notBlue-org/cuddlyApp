
import 'dart:async';
import 'package:diaryapp/screens/home/widget/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(
        const Duration(
          seconds: 2,
        ),(){
      Navigator.pushReplacement(context,MaterialPageRoute(
        builder:(context)=>HomePage(),
      ));
    }
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(
          child: Image.asset('assets/images/Notblue.png'),
        )
    );
  }
}