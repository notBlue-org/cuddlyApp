import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/constants/colors.dart';
import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/static_assets/home_bottom_wave.dart';
import 'package:diaryapp/utils/login.dart';

import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

import '../../models/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:diaryapp/models/user_stored.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // final user = box.values.toList().cast<UserStore>();
    final box = Boxes.getUserStore();
    final username = box.values.toList().elementAt(0).username;
    final id=box.values.toList().elementAt(0).id;
    return Scaffold( 
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      drawer: const NavDrawer(),
      appBar: custAppBar("Home"),
      body: Center(
        child: Column(
          children: [
            SizedBox(
                height: 150,
                child: Stack(
                    children: [Positioned(top: 0, child: CustomWaveSvg())])),
            
            ..._getField(width, "Distributor Name", username.toString()),
            const SizedBox(
              height: 10,
            ),
            ..._getField(width, "Amount Due", 'Hello'),
            const SizedBox(
              height: 10,
            ),
            ..._getField(width, "Crates Remaining", "10"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed(
                    '/order_page',
                  );
                },
                style: ElevatedButton.styleFrom(primary: kButtonColor),
                child: const Text('Order Now!')),
            Expanded(
                child: Stack(children: [
              Positioned(bottom: 0, child: HomeBottomWave())
            ])),
          ],
        ),
      ),
    );
  }
}

_getField(width, label, value) {
  return [
    Container(
      padding: EdgeInsets.fromLTRB(0.1 * width, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        textAlign: TextAlign.left,
        style:
            const TextStyle(color: kButtonColor, fontWeight: FontWeight.bold),
      ),
    ),
    const SizedBox(
      height: 5,
    ),
    Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(13, 21, 129, 0.03),
                blurRadius: 100.0,
                offset: Offset(0, 10.0),
                spreadRadius: 2,
              ),
            ]),
        height: 50,
        width: 0.8 * width,
        padding: const EdgeInsets.all(15),
        child: Text(
          value,
          style: const TextStyle(color: kButtonColor),
        ))
  ];
}
