import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/constants/colors.dart';
import 'package:diaryapp/models/user_stored.dart';
import 'package:diaryapp/models/boxes.dart';
import 'package:diaryapp/utils/login.dart';
import 'package:diaryapp/utils/misc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../static_assets/wave_svg.dart';
import '../static_assets/bottom_wave.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GlobalKey<State> _keyLoader = GlobalKey<State>();
final _loginId = TextEditingController();
final _passwordId = TextEditingController();
final _formKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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
            body: Center(
                child: Column(children: [
              SizedBox(
                  height: 150,
                  child:
                      Stack(children: [Positioned(top: 0, child: WaveSvg())])),
              const Expanded(
                child: SizedBox(),
              ),
              const Text(
                "Welcome",
                style: TextStyle(
                  color: kButtonColor,
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Login(),
              const Expanded(
                child: SizedBox(),
              ),
              Expanded(
                  child: Stack(children: [
                Positioned(bottom: -250, child: BottomWave())
              ])),
            ]))));
  }
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _usernameField(width),
            const SizedBox(
              height: 20,
            ),
            _passwordField(width),
            const SizedBox(
              height: 20,
            ),
            const LoginButton(),
          ],
        ));
  }
}

Widget _usernameField(width) {
  // return SizedBox(
  // width: 300,
  return Container(
    height: 50,
    width: 0.8 * width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(13, 21, 129, 0.03),
            blurRadius: 100.0,
            offset: Offset(0, 10.0),
            spreadRadius: 2,
          ),
        ]),
    // color: Colors.white,
    child: Center(
      child: TextFormField(
        textAlign: TextAlign.center,
        decoration: const InputDecoration.collapsed(
          hintText: 'Email ID',
        ),
        controller: _loginId,
      ),
    ),
    // ),
  );
}

Widget _passwordField(width) {
  return Container(
    height: 50,
    width: 0.8 * width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(13, 21, 129, 0.03),
            blurRadius: 5.0,
            offset: Offset(0, 10.0),
            spreadRadius: 2,
          ),
        ]),
    // color: Colors.white,
    child: Center(
      child: TextFormField(
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: const InputDecoration.collapsed(
          hintText: 'Password',
        ),
        controller: _passwordId,
      ),
    ),
    // ),
  );
}

class LoginButton extends StatefulWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  void _loginUser(BuildContext context) async {
    String email = _loginId.text.trim();
    String password = _passwordId.text.trim();

    FocusScope.of(context).unfocus();

    String? validationResult = Validator.validate(
        email: _loginId.text.trim(), password: _passwordId.text.trim());
    if (validationResult != null) {
      Misc.createSnackbar(context, validationResult);
      return;
    } else {
      Misc.showLoadingDialog(context, _keyLoader);
      User? currentUser = await FireAuth.signInUsingEmailPassword(
          context: context, email: email, password: password);
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();

      // Added by Adi
      await FirebaseFirestore.instance
          .collection('Distributors')
          .where("Email", isEqualTo: currentUser!.email)
          .get()
          .then((QuerySnapshot data) {
        Map currentUserFirestore = data.docs.elementAt(0).data() as Map;
        final userData = UserStore();
        userData.id = data.docs.elementAt(0).id;
        userData.username = currentUserFirestore["Name"];
        userData.route = currentUserFirestore["Route"];
        userData.email = currentUserFirestore['Email'];
        if (currentUserFirestore['GST Type'] == 'Regular') {
          userData.isB2B = true;
        } else {
          userData.isB2B = false;
        }

        List<String> brands = currentUserFirestore['Brand'].split(',');

        for (var brand in brands) {
          brand = brand.trim();
        }
        userData.brands = brands;

        final box = Boxes.getUserStore();
        box.put(0, userData);
      });

      try {
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(
          '/reminder_page',
        );
      } catch (e) {
        if (!mounted) return;
        Misc.createSnackbar(context, 'Error: $e.code');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      width: 0.8 * width,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          _loginUser(context);
        },
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          primary: kButtonColor,
          textStyle: const TextStyle(
            fontFamily: 'google sans',
            fontSize: 20,
          ),
        ),
        child: const Text('Login'),
      ),
    );
  }
}
