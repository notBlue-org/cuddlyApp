import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/constants/colors.dart';
import 'package:diaryapp/models/boxes.dart';
import 'package:diaryapp/screens/app/home_page.dart';
import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/app_bar_gray.dart';
import 'package:flutter/material.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const NavDrawer(),
        appBar: grayCustAppBar("Reminder"),
        body: Column(children: [
          SizedBox(
              height: 150,
              child: Stack(
                  children: [Positioned(top: 0, child: CustomWaveSvg())])),
          const Center(child: ReminderMain())
        ]));
  }
}

class ReminderMain extends StatelessWidget {
  const ReminderMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final box = Boxes.getUserStore();
    var _userDetails = box.values.toList().elementAt(0);
    return FutureBuilder<List<dynamic>>(
        future: Future.wait(
            [_getAmount(_userDetails.id), _getCrate(_userDetails.id)]),
        builder: (context, snapshot) {
          if (ConnectionState.done == snapshot.connectionState) {
            return Column(
              children: [
                const Text("Number of crates to be returned"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                        snapshot.data![1].toString(),
                        style: const TextStyle(color: kButtonColor),
                      )),
                ),
                const Text("Amount that has to be paid"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                        snapshot.data![0].toString(),
                        style: const TextStyle(color: kButtonColor),
                      )),
                ),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        ),
                    child: const Text('I agree'))
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

Future<String> _getCrate(id) async {
  var document =
      await FirebaseFirestore.instance.collection('Distributors').doc(id).get();
  Map<String, dynamic>? value = document.data();
  return value!['Crates'];
}

Future<String> _getAmount(id) async {
  var document =
      await FirebaseFirestore.instance.collection('Distributors').doc(id).get();
  Map<String, dynamic>? value = document.data();
  return value!['AmountDue'];
}
