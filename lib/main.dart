import 'dart:async';

import 'package:flutter/material.dart';

import 'screens/register_screen.dart';

void main() {
  runApp(diaryapp());
}

class diaryapp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:SplashScreen(),
    );
  }
}




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
            builder:(context)=>RegisterScreen(),
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
        child: Image.asset('images/Notblue.png'),
      )
    );
  }
}



