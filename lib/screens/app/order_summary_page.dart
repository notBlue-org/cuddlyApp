import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/models/order_instance.dart';
import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const NavDrawer(),
        appBar: custAppBar("Order Summary"),
        // body: FutureBuilder<List<OrderInstance>>(
        //   future: _getData(),
        //   builder: (BuildContext context,
        //       AsyncSnapshot<List<OrderInstance>> snapshot) {
        //     if (snapshot.hasError) {
        //       return const Text("Something went wrong");
        //     } else if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     } else if (snapshot.hasData &&
        //         snapshot.connectionState == ConnectionState.done) {
        //       return ListView.builder(
        //           padding: const EdgeInsets.all(8),
        //           itemCount: snapshot.data!.length,
        //           itemBuilder: (BuildContext context, int index) {
        //             return Container(
        //               height: 50,
        //               color: Colors.amber,
        //               child: Center(child: Text('${snapshot.data![1].otp}')),
        //             );
        //           });
        //     } else {
        //       return const Text("Unknown Error");
        //     }
        //   },
        // )
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            height: 50,
            width: 500,
            color: Colors.white,
            child: Text('Data'),
          ),
        ));
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
