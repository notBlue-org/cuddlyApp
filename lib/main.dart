import 'package:diaryapp/models/user_stored.dart';
import 'package:diaryapp/providers/cart_provider.dart';
import 'package:diaryapp/utils/route_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase/firebase_options.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(UserStoreAdapter());
  await Hive.openBox<UserStore>('user');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const DiaryApp()));
  // runApp(const DiaryApp());
}

class DiaryApp extends StatefulWidget {
  const DiaryApp({Key? key}) : super(key: key);

  @override
  State<DiaryApp> createState() => _DiaryAppState();
}

class _DiaryAppState extends State<DiaryApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
        theme: ThemeData(fontFamily: 'Poppins'),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (!mounted) return firebaseApp;
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      Navigator.of(context).pushReplacementNamed(
        '/reminder_page',
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        return const SplashScreen();
      },
    );
  }
}
