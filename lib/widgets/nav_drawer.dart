import 'package:diaryapp/constants/colors.dart';
import 'package:diaryapp/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Menu Items',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => {
              Navigator.of(context).pushReplacementNamed(
                '/home_page',
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.next_week_sharp),
            title: const Text('New Order'),
            onTap: () => {
              Navigator.of(context).pushReplacementNamed(
                '/order_page',
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_rounded),
            title: const Text('All Orders'),
            onTap: () => {
              Navigator.of(context).pushReplacementNamed(
                '/order_summary_page',
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => {
              Navigator.of(context).pushReplacementNamed(
                '/profile_page',
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () async => {
              await FirebaseAuth.instance.signOut(),
              Navigator.of(context).pushReplacementNamed(
                '/login_page',
              )
            },
          ),
        ],
      ),
    );
  }
}
