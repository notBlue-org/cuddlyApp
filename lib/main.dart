import 'package:diaryapp/screens/home.dart';
import 'package:diaryapp/screens/login.dart';
import 'package:diaryapp/screens/order_summary.dart';
import 'package:diaryapp/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diaryapp/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DiaryApp());
}

class DiaryApp extends StatefulWidget {
  const DiaryApp({Key? key}) : super(key: key);

  @override
  _DiaryAppState createState() => _DiaryAppState();
}

class _DiaryAppState extends State<DiaryApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      routes: {
        '/shopping_home': (ctx) => const HomePage(),
        '/order_summary': (ctx) => const OrderSummary(),
        '/login_page': (ctx) => const LoginScreen(),
        '/profile_page': (ctx) => const ProfileScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacementNamed(
        '/shopping_home',
        arguments: {'user': user},
      );
    }
    else{
      Navigator.of(context).pushReplacementNamed(
        '/login_page',
      );
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        return const SplashScreen();
      },
    );
  }
}
