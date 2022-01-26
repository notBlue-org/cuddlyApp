import 'package:cloud_firestore/cloud_firestore.dart';
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
          body: Stack(alignment: Alignment.center, children: [
            Positioned(
              top: -10,
              child: WaveSvg(),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 6 + 100,
              child: const Login(),
            ),
            Positioned(
              bottom: -310,
              child: BottomWave(),
            )
          ]),
        ));
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
              height: 10,
            ),
            _passwordField(width),
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
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  void _loginUser(BuildContext context) async {
    String email = _loginId.text.trim();
    String password = _passwordId.text.trim();

    FocusScope.of(context).unfocus();

    String? _validationResult = Validator.validate(
        email: _loginId.text.trim(), password: _passwordId.text.trim());
    if (_validationResult != null) {
      Misc.createSnackbar(context, _validationResult);
      return;
    } else {
      Misc.showLoadingDialog(context, _keyLoader);
      User? _currentUser = await FireAuth.signInUsingEmailPassword(
          context: context, email: email, password: password);
      Navigator.of(context, rootNavigator: true).pop();

      // Added by Adi
      await FirebaseFirestore.instance
          .collection('Distributors')
          .where("Email", isEqualTo: _currentUser!.email)
          .get()
          .then((QuerySnapshot data) {
        Map _currentUserFirestore = data.docs.elementAt(0).data() as Map;

        final userData = UserStore();
        userData.id = data.docs.elementAt(0).id;
        userData.username = _currentUserFirestore["Name"];
        userData.type = _currentUserFirestore["Type"];
        userData.email = _currentUserFirestore['Email'];
        List<String> _brands = _currentUserFirestore['Brand'].split(',');
        for (var brand in _brands) {
          brand = brand.trim();
        }
        userData.brands = _brands;

        final box = Boxes.getUserStore();
        box.put(0, userData);
      });

      try {
        Navigator.of(context).pushReplacementNamed(
          '/home_page',
        );
      } catch (e) {
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
      width: 0.6 * width,
      height: 50,
      child: ElevatedButton(
        child: const Text('Login'),
        onPressed: () {
          _loginUser(context);
        },
        style: ElevatedButton.styleFrom(
          primary: const Color(0xff23233c),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}
