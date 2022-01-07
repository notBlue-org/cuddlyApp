import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/utils/misc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class CurrentUser extends ChangeNotifier {
  late User _user;
  late String _uuid;
  late String _email;
  late String _name;
  late String _type;
  late bool _isEmailVerified;

  String get getUuid => _uuid;
  String get getEmail => _email;
  String get getName => _name;
  bool get getIsEmailVerified => _isEmailVerified;
  User get getUser => _user;
  String get getType => _type;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> signIn(
      BuildContext context, String email, String password) async {
    bool isSignedIn = false;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        isSignedIn = true;
        _user = userCredential.user!;
        _uuid = _user.uid;
        _email = _user.email!;
        _name = "";
        _type = "";
        _isEmailVerified = _user.emailVerified;

        await _firestore
            .collection('Distributors')
            .where('Email', isEqualTo: _user.email)
            .get()
            .then((QuerySnapshot data) {
          Map userDetails = data.docs.elementAt(0).data() as Map;
          _name = userDetails["Name"];
          _type = userDetails["Type"];
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Misc.createSnackbar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Misc.createSnackbar(context, 'Wrong password provided.');
      }
    } catch (e) {
      Misc.createSnackbar(context, 'Unknown error!');
    }
    return isSignedIn;
  }

  Future<void> verifyEmail() async {
    await _user.sendEmailVerification();
    await _user.reload();
    _user = _auth.currentUser!;
    _isEmailVerified = _user.emailVerified;
  }
}
