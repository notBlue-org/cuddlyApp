import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/utils/login.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0.0,
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            Positioned(
              top: -10,
              child: CustomWaveSvg(),
            ),
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
