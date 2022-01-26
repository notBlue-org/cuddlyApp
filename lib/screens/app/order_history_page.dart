import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/models/order_instance.dart';
import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const NavDrawer(),
      appBar: custAppBar("Order History"),
      body: Center(
        child: Column(
          children: [
            CustomWaveSvg(),
            const Text('All Orders Will Be displayed here'),
          ],
        ),
      ),
    );
  }
}

Future<List<OrderInstance>> _getData() async {
  List<OrderInstance> tmpList = [];
  await FirebaseFirestore.instance
      .collection('Orders')
      .get()
      .then((QuerySnapshot data) {
    for (var doc in data.docs) {
      var dataD = doc.data() as Map;
      tmpList.add(OrderInstance(
          otp: dataD["OTP"],
          productList: dataD["ProductList"],
          status: dataD["Status"],
          totalPrice: dataD["Total Price"]));
    }
  });
  return tmpList;
}
