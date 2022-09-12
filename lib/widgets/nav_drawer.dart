import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/constants/colors.dart';
import 'package:diaryapp/utils/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/boxes.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Drawer(
        child: Material(
          color: kPrimaryColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // CustomInvertWaveSvg(),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                  ),
                ),
              ),
              _getListTile(context, Icons.home, 'Home', '/home_page'),
              const Divider(
                color: Colors.white,
                indent: 10.0,
                endIndent: 30.0,
              ),
              _getOrderTile(
                  context, Icons.next_week_sharp, 'New Order', '/order_page'),
              const Divider(
                color: Colors.white,
                indent: 10.0,
                endIndent: 30.0,
              ),
              _getListTile(context, Icons.list_alt_rounded, 'All Orders',
                  '/order_history_page'),
              const Divider(
                color: Colors.white,
                indent: 10.0,
                endIndent: 30.0,
              ),
              _getListTile(context, Icons.person, 'Profile', '/profile_page'),
              const Divider(
                color: Colors.white,
                indent: 10.0,
                endIndent: 30.0,
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: const Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () async => {
                  FireAuth.signOut(context),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_getListTile(
    BuildContext context, IconData givenIcon, String label, String navPage) {
  return ListTile(
    leading: Icon(
      givenIcon,
      color: Colors.white,
    ),
    title: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    onTap: () => {
      Navigator.of(context).pushReplacementNamed(
        navPage,
      )
    },
  );
}

isAfterTime() async {
  final box = Boxes.getUserStore();
  final id = box.values.toList().elementAt(0).id;
  var cutOffTime = await FirebaseFirestore.instance
      .collection('Distributors')
      .doc(id)
      .get()
      .then((value) => value.data()!['CutoffTime']);

  // Conveting String to date time formats
  var actualTime =
      DateFormat('kk:mm').parse(DateFormat('kk:mm').format(DateTime.now()));
  var cutOffTimeParsed = DateFormat('kk:mm').parse(cutOffTime);
  return actualTime.isBefore(cutOffTimeParsed);
}

void showSnackBarAsBottomSheet(BuildContext context, String message) {
  showModalBottomSheet<void>(
    context: context,
    barrierColor: const Color.fromRGBO(0, 0, 0, 0),
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 5), () {
        try {
          Navigator.pop(context);
        } on Exception {}
      });
      return Container(
          color: Colors.grey.shade800,
          padding: const EdgeInsets.all(12),
          child: Wrap(children: [
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            )
          ]));
    },
  );
}

_getOrderTile(
    BuildContext context, IconData givenIcon, String label, String navPage) {
  return ListTile(
    leading: Icon(
      givenIcon,
      color: Colors.white,
    ),
    title: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    onTap: () async => {
      if (await isAfterTime())
        {
          Navigator.of(context).pushReplacementNamed(
            navPage,
          )
        }
      else
        {
          showSnackBarAsBottomSheet(context, "Ordering time is over")
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Ordering time is over'),
          //     behavior: SnackBarBehavior.floating,
          //   ),
          // )
        }
    },
  );
}
