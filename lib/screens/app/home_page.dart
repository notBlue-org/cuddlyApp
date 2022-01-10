import 'package:diaryapp/utils/login.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  FireAuth.signOut(context);
                },
                child: const Text('Sign out'))
          ],
        ),
      ),
    );
  }
}
