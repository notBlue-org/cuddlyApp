import 'package:diaryapp/screens/login.dart';
import 'package:diaryapp/utils/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ProfileScreen> {
  late User _currentUser;
  bool _isSendingVerification = false;
  bool _isSigningOut = false;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Page'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: ${_currentUser.displayName}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'Email: ${_currentUser.email}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 16.0),
            _currentUser.emailVerified
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
            const SizedBox(height: 16.0),
            _isSendingVerification
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isSendingVerification = true;
                          });
                          await _currentUser.sendEmailVerification();
                          setState(() {
                            _isSendingVerification = false;
                          });
                        },
                        child: const Text('Verify email'),
                      ),
                      const SizedBox(width: 8.0),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () async {
                          User? user = await FireAuth.refreshUser(_currentUser);

                          if (user != null) {
                            setState(() {
                              _currentUser = user;
                            });
                          }
                        },
                      ),
                    ],
                  ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('Sign out'))
          ],
        )),
      ),
    );
  }
}
