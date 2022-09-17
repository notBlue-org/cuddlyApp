import 'package:diaryapp/constants/colors.dart';
import 'package:diaryapp/models/user_stored.dart';
import 'package:diaryapp/models/boxes.dart';
import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/utils/login.dart';
import 'package:diaryapp/utils/misc.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _currentPasswordId = TextEditingController();
final _newPasswordId = TextEditingController();
final _newPasswordId2 = TextEditingController();

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const NavDrawer(),
        appBar: custAppBar("Change Password"),
        body: Column(children: [
          SizedBox(
              height: 150,
              child: Stack(
                  children: [Positioned(top: 0, child: CustomWaveSvg())])),
          const SizedBox(height: 8.0),
          _passwordField(width, "Enter Current Password", _currentPasswordId),
          const SizedBox(height: 8.0),
          _passwordField(width, "Enter New Password", _newPasswordId),
          const SizedBox(height: 8.0),
          _passwordField(width, "Enter New Password Again", _newPasswordId2),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: kButtonColor),
              onPressed: () async {
                _changePassword(context);
              },
              child: const Text('Submit'))
        ]));
  }
}

Widget _passwordField(width, hintText, controller) {
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
    child: Center(
      child: TextFormField(
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration.collapsed(
          hintText: hintText,
        ),
        controller: controller,
      ),
    ),
  );
}

void _changePassword(context) async {
  String currentPassword = _currentPasswordId.text.trim();
  String newPasswordId = _newPasswordId.text.trim();
  String newPasswordId2 = _newPasswordId2.text.trim();
  final userBox = await Hive.openBox<UserStore>('user');
  final email = userBox.getAt(0)?.email;

  if (newPasswordId != newPasswordId2) {
    Misc.createSnackbar(context, "Passwords do not match");
  }
  String? validationResult =
      Validator.validate(email: email.toString(), password: newPasswordId);
  if (validationResult != null) {
    Misc.createSnackbar(context, validationResult);
    return;
  } else {
    final user = FirebaseAuth.instance.currentUser;
    try {
      final cred = EmailAuthProvider.credential(
          email: email.toString(), password: currentPassword);
      user?.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPasswordId).then((_) {
          Misc.createSnackbar(
              context, "Successfully changed password! Log in Again");
          _currentPasswordId.text = "";
          _newPasswordId.text = "";
          _newPasswordId.text = "";
          FireAuth.signOut(context);
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Misc.createSnackbar(context, "Wrong password provided.");
        return;
      } else {
        Misc.createSnackbar(context, e.toString());
        return;
      }
    }
  }
}
