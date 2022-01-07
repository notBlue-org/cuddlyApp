import 'package:diaryapp/providers/users.dart';
import 'package:diaryapp/screens/login_page.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<CurrentUser>(context, listen: false);

    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('data'),
            ElevatedButton(
                onPressed: () async {
                  _currentUser.signOut(context);
                },
                child: const Text('Sign out'))
          ],
        ),
      ),
    );
  }
}
