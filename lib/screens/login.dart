import 'package:diaryapp/screens/home.dart';
import 'package:diaryapp/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diaryapp/utils/login.dart';
import '../static_assets/wave_svg.dart';
import '../static_assets/bottom_wave.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final loginId = TextEditingController();
final password = TextEditingController();
final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Stack(alignment: Alignment.center, children: [
        Positioned(
          top: -10,
          child: wave_svg(),
        ),
        // waveBar(),
        Positioned(
          top: MediaQuery.of(context).size.height / 6 + 100,
          child: Login(),
        ),
        Positioned(
          bottom: -310,
          child: BottomWave(),
        )
      ]),
    );
  }
}

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final FireAuth authInst = FireAuth();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _usernameField(),
            _passwordField(),
            _loginButton(context)
          ],
        ));
  }
}

Widget _usernameField() {
  return SizedBox(
    width: 300,
    child: Card(
      color: Colors.white70,
      child: TextFormField(
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          hintText: 'Username',
        ),
        validator: (value) => Validator.validateEmail(email: value),
        controller: loginId,
      ),
    ),
  );
}

Widget _passwordField() {
  return SizedBox(
    width: 300,
    child: Card(
      color: Colors.white70,
      child: TextFormField(
          obscureText: true,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            hintText: 'Password',
          ),
          controller: password,
          validator: (value) => Validator.validatePassword(password: value)),
    ),
  );
}

Widget _loginButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(
      vertical: 20,
    ),
    width: 280,
    
    child: ElevatedButton(
      child: const Text('Login'),
      style: ElevatedButton.styleFrom(
        primary: const Color(0xff23233c),
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 26,
        ),
      ),
      onPressed: () async {
        User? user = await FireAuth.signInUsingEmailPassword(
            email: loginId.text, password: password.text, context: context);
        if (user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
          );
        } else {
          const snackBar =
              SnackBar(content: Text('Login Failed! Please Try Again!'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    ),
  );
}
