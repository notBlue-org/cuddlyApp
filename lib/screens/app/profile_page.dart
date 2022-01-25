import 'package:diaryapp/constants/colors.dart';
import 'package:diaryapp/models/user_stored.dart';
import 'package:diaryapp/models/boxes.dart';
import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/utils/login.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const NavDrawer(),
        appBar: custAppBar("Profile Page"),
        body: Column(children: [CustomWaveSvg(), const ProfileBody()]));
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<UserStore>>(
      valueListenable: Boxes.getUserStore().listenable(),
      builder: (context, box, _) {
        final userDetails = box.values.toList().cast<UserStore>();
        return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Name: ${userDetails.elementAt(0).username}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  'User Class: ${userDetails.elementAt(0).type}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  'Email: ${userDetails.elementAt(0).email}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kButtonColor),
                    onPressed: () async {
                      FireAuth.signOut(context);
                    },
                    child: const Text('Sign out'))
              ]),
        );
      },
    );
  }
}
