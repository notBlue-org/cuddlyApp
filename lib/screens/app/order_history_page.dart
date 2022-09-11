// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/models/boxes.dart';
import 'package:diaryapp/models/order_instance.dart';
import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const NavDrawer(),
        appBar: custAppBar("Order History"),
        body: const OrderHistoryPageBody());
  }
}

class OrderHistoryPageBody extends StatefulWidget {
  const OrderHistoryPageBody({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPageBody> createState() => OrderHistoryPageBodyState();
}

class OrderHistoryPageBodyState extends State<OrderHistoryPageBody> {
  late Future<List<OrderInstance>> _getData;
  @override
  void initState() {
    _getData = _getOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 150,
            child:
                Stack(children: [Positioned(top: 0, child: CustomWaveSvg())])),
        FutureBuilder<List<OrderInstance>>(
            future: _getData, // a previously-obtained Future<String> or null
            builder: (BuildContext context,
                AsyncSnapshot<List<OrderInstance>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) => _listContainer(
                          snapshot.data!.elementAt(index), context),
                      padding: const EdgeInsets.all(10),
                      itemCount: snapshot.data?.length,
                      scrollDirection: Axis.vertical,
                    ),
                  );
                } else {
                  Navigator.of(context).pushNamed(
                    "/error_page",
                  );
                  return const Text("Error!");
                }
              } else {
                Navigator.of(context).pushNamed(
                  "/error_page",
                );
                return const Text("Data not loading!");
              }
            })
      ],
    );
  }
}

_listContainer(OrderInstance data, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
    child: Container(
      constraints:
          const BoxConstraints(minHeight: 90, minWidth: double.infinity),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Expanded(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Order ID:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                      Text("#${data.id}".substring(10),
                          style: const TextStyle(
                              color: Colors.black,
                              height: 1.5,
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(
                    width: 45,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Status",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                      Text(data.status,
                          style: const TextStyle(
                              color: Colors.black,
                              height: 1.5,
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(
                    width: 45,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Otp",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 1.0,
                        ),
                      ),
                      Text(_otpGetter(data),
                          style: const TextStyle(
                              color: Colors.black,
                              height: 1.5,
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(
                    width: 45,
                  ),
                  // GestureDetector(
                  //     onTap: () {
                  //       Navigator.of(context).pushNamed(
                  //         '/order_history_details_page',
                  //         arguments: data,
                  //       );
                  //     },
                  //     child: const Icon(Icons.arrow_forward_ios))
                ]),
          ),
          // ),
        ],
      ),
    ),
  );
}

String _otpGetter(var data) {
  if (data.status == "Delivered") {
    return "-";
  } else {
    return data.otp;
  }
}

Future<List<OrderInstance>> _getOrderData() async {
  final box = Boxes.getUserStore();

  var userDetails = box.values.toList().elementAt(0);

  List<OrderInstance> orderList = [];
  DateTime now = DateTime.now();
  String month = now.month.toString().length == 2
      ? now.month.toString()
      : '0${now.month}';
  for (var i = now.day; i > 0; i--) {
    String day = i.toString().length == 2 ? i.toString() : '0$i';
    String orderDate = 'Orders_${day}-${month}-${now.year.toString().substring(2, 4)}';
    await FirebaseFirestore.instance
        .collection(orderDate)
        .where("DistributorID", isEqualTo: userDetails.id)
        .get()
        .then((QuerySnapshot data) {
      for (var doc in data.docs) {
        var dataD = doc.data() as Map;
        orderList.add(OrderInstance(
            id: doc.id,
            paymentType: dataD["PaymentType"],
            otp: dataD["OTP"],
            productList: dataD["ProductList"],
            status: dataD["Status"],
            totalPrice: dataD["Total Price"],
            route: dataD["Route"]));
      }
    });
    // print(_orderList);
    // print(orderDate);
  }

  return orderList;
}
