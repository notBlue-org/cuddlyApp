import 'package:diaryapp/providers/users.dart';
import 'package:diaryapp/screens/login_page.dart';
import 'package:diaryapp/utils/misc.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Text('Profile Page'),
        ),
        body: const Center(child: ProfileBody()));
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<CurrentUser>(context);

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'Name: ${_currentUser.getName}',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      Text(
        'User Class: ${_currentUser.getType}',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      Text(
        'Email: ${_currentUser.getEmail}',
        style: Theme.of(context).textTheme.bodyText1,
      ),
      const SizedBox(height: 16.0),
      _currentUser.getIsEmailVerified!
          ? Text(
              'Email verified',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.green),
            )
          : Text(
              'Email not verified',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.red),
            ),
      const VerificationBody(),
      ElevatedButton(
          onPressed: () async {
            _currentUser.signOut(context);
          },
          child: const Text('Sign out'))
    ]);
  }
}

class VerificationBody extends StatefulWidget {
  const VerificationBody({Key? key}) : super(key: key);

  @override
  _VerificationBodyState createState() => _VerificationBodyState();
}

class _VerificationBodyState extends State<VerificationBody> {
  bool _isSendingVerification = false;

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<CurrentUser>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 16.0),
        _isSendingVerification
            ? const CircularProgressIndicator()
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_currentUser.getIsEmailVerified!) {
                        Misc.createSnackbar(
                            context, "Email has been verified already.");
                        return;
                      } else {
                        Misc.createSnackbar(context,
                            "Email sent! Follow instructions in the email to verify your email.");
                      }
                      setState(() {
                        _isSendingVerification = true;
                      });
                      await _currentUser.verifyEmail();
                      setState(() {
                        _isSendingVerification = false;
                      });
                    },
                    child: const Text('Verify email'),
                  ),
                  const SizedBox(width: 8.0),
                ],
              ),
      ],
    );
  }
}
