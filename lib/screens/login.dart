import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diaryapp/utils/login.dart';
import '../static_assets/wave_svg.dart';
import '../static_assets/bottom_wave.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final _loginId = TextEditingController();
final _passwordId = TextEditingController();
final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
<<<<<<< HEAD
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Stack(alignment: Alignment.center, children: [
        Positioned(
          top: -10,
          child: WaveSvg(),
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
=======
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
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
        ));
>>>>>>> 2d5770b3ca70440d2bbea85624b7b92667c1a856
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
          hintText: 'Email ID',
        ),
        controller: _loginId,
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
        controller: _passwordId,
      ),
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
<<<<<<< HEAD
        User? user = await FireAuth.signInUsingEmailPassword(
            email: loginId.text, password: password.text, context: context);
        if (user != null) {
          Navigator.of(context).pushReplacementNamed(
            '/shopping_home',
            arguments: {'user': user},
          );
        } else {
          const snackBar =
              SnackBar(content: Text('Login Failed! Please Try Again!'));
=======
        FocusScopeNode currentFocus = FocusScope.of(context);
        currentFocus.unfocus();
        String loginText = _loginId.text.trim();
        String passwordText = _passwordId.text.trim();

        String? _validationResult = Validator.validate(
            {loginText, passwordText},
            email: loginText, password: passwordText);

        if (_validationResult != null) {
          var snackBar = SnackBar(content: Text(_validationResult));
>>>>>>> 2d5770b3ca70440d2bbea85624b7b92667c1a856
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        } else {
          User? user = await FireAuth.signInUsingEmailPassword(
              email: loginText, password: passwordText, context: context);
          if (user != null) {
            Navigator.of(context).pushReplacementNamed(
              '/profile_page',
              arguments: {'user': user},
            );
          }
        }
      },
    ),
  );
}
