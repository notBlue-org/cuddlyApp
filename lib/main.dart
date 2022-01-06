import 'package:diaryapp/providers/cart.dart';
import 'package:diaryapp/utils/route_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/splash_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase/firebase_options.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';
import './providers/cart_counter_provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => CartCounterMove())
      ],
      child: const MaterialApp(
        home: MainScreen(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
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
        '/home_page',
        // arguments: {'user': user},
      );
    } else {
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
