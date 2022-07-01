import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

class OrderHistoryDetailsPage extends StatelessWidget {
  final _objectData;
  const OrderHistoryDetailsPage(this._objectData, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const NavDrawer(),
        appBar: custAppBar("Order Details"),
        body: OrderHistoryDetailsPageBody(_objectData));
  }
}

class OrderHistoryDetailsPageBody extends StatefulWidget {
  const OrderHistoryDetailsPageBody(objectData, {Key? key}) : super(key: key);

  @override
  State<OrderHistoryDetailsPageBody> createState() =>
      OrderHistoryDetailsPageBodyState();
}

class OrderHistoryDetailsPageBodyState
    extends State<OrderHistoryDetailsPageBody> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: 150,
          child: Stack(children: [Positioned(top: 0, child: CustomWaveSvg())])),
          // FutureBuilder<List<OrderInstance>>(
          //   future: _getData, // a previously-obtained Future<String> or null
          //   builder: (BuildContext context,
          //       AsyncSnapshot<List<OrderInstance>> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const CircularProgressIndicator();
          //     } else if (snapshot.connectionState == ConnectionState.done) {
          //       if (snapshot.hasData) {
          //         return Expanded(
          //           child: ListView.builder(
          //             shrinkWrap: true,
          //             itemBuilder: (ctx, index) => _listContainer(
          //                 snapshot.data!.elementAt(index), context),
          //             padding: const EdgeInsets.all(10),
          //             itemCount: 4,
          //             scrollDirection: Axis.vertical,
          //           ),
          //         );
          //       } else {
          //         Navigator.of(context).pushNamed(
          //           "/error_page",
          //         );
          //         return const Text("Error!");
          //       }
          //     } else {
          //       Navigator.of(context).pushNamed(
          //         "/error_page",
          //       );
          //       return const Text("Data not loading!");
          //     }
          //   })
    ]);
  }
}


// Future<List<OrderInstance>> _getOrderData() async {
//   final box = Boxes.getUserStore();

//   var _userDetails = box.values.toList().elementAt(0);

//   List<OrderInstance> _orderList = [];
//   await FirebaseFirestore.instance
//       .collection('Orders')
//       .where("DistributorID", isEqualTo: _userDetails.id)
//       .get()
//       .then((QuerySnapshot data) {
//     for (var doc in data.docs) {
//       var dataD = doc.data() as Map;
//       _orderList.add(OrderInstance(
//           id: doc.id,
//           paymentType: dataD["PaymentType"],
//           otp: dataD["OTP"],
//           productList: dataD["ProductList"],
//           status: dataD["Status"],
//           totalPrice: dataD["Total Price"]));
//     }
//   });
//   return _orderList;
// }

