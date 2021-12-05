import 'dart:async';

import 'package:diaryapp/screens/splashScreen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(diaryapp());
}

class diaryapp extends StatelessWidget {

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:SplashScreen(),
    );
  }
}








