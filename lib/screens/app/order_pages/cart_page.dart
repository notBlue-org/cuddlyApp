import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/models/user_stored.dart';
// import 'package:diaryapp/providers/brand.dart';
import 'package:diaryapp/providers/cart_provider.dart';
import 'package:diaryapp/screens/app/sucess_pages/sucess_page.dart';
import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/order_widgets/cart_item.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/order_widgets/order_summary.dart';
import 'package:diaryapp/widgets/order_widgets/payment_gateway.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../models/boxes.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: custAppBar("Cart"),
      body: Column(
        children: [
          SizedBox(
              height: 150,
              child: Stack(
                  children: [Positioned(top: 0, child: CustomWaveSvg())])),
          const Text(
            "Order Details",
            style: TextStyle(fontSize: 30),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              shrinkWrap: true,
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) => CartItemWid(
                id: cart.items.values.toList()[i].id,
                price: cart.items.values.toList()[i].price,
                quantity: cart.items.values.toList()[i].quantity,
                title: cart.items.values.toList()[i].title,
                productId: cart.items.keys.toList()[i],
                imgUrl: cart.items.values.toList()[i].imgUrl,
                desciption: cart.items.values.toList()[i].desciption,
              ),
            ),
          ),
          OrderSummary(cart: cart),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                // OnlineOrderButton(),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: CoDButton(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CoDButton extends StatelessWidget {
  const CoDButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderData = Provider.of<Cart>(context);
    DateTime now = DateTime.now();
    String day = now.day.toString().length == 2
        ? now.day.toString()
        : '0' + now.day.toString();
    String month = now.month.toString().length == 2
        ? now.month.toString()
        : '0' + now.month.toString();
    String orderDate = 'Orders_' +
        day +
        "-" +
        month +
        "-" +
        now.year.toString().substring(2, 4);
    Map<String, CartItem> tmp = orderData.items;
    // CollectionReference order =
    //     FirebaseFirestore.instance.collection(orderDate);
    Map<String, List> orders = {};
    Map<String, List> getOrders() {
      for (var i in tmp.values) {
        orders[i.id] = [i.quantity, i.brand];
      }
      return orders;
    }

    generateOtp() {
      var rng = Random();
      int rand = rng.nextInt(8888) + 1000;
      String stringValue = rand.toString();
      return stringValue;
    }

    Future<String> generateOrderId() async {
      var collection = FirebaseFirestore.instance.collection('Variable');
      var docSnapshot = await collection.doc('variable').get();
      DateTime now = DateTime.now();

      String day = now.day.toString().length == 2
          ? now.day.toString()
          : '0' + now.day.toString();
      String month = now.month.toString().length == 2
          ? now.month.toString()
          : '0' + now.month.toString();
      String time = now.year.toString().substring(2,4) + month + day;
      var orderIdString;
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        final box = Boxes.getUserStore();
        final isB2b = box.values.toList().elementAt(0).isB2B;
        if (isB2b) {
          var orderIdInt = int.parse(data!['B2B']) + 1;
          orderIdString = 'B2B' + time + orderIdInt.toString().substring(1, 8);
          collection
              .doc('variable')
              .update({'B2B': orderIdInt.toString()})
              .then((_) => {})
              .catchError((error) => {});
        } else {
          var orderIdInt = int.parse(data!['B2C']) + 1;
          orderIdString = 'B2B' + time + orderIdInt.toString().substring(1, 8);
          collection
              .doc('variable')
              .update({'B2C': orderIdInt.toString()})
              .then((_) => {})
              .catchError((error) => {});
        }

        return orderIdString;
      }
      return '';
    }

    Future<void> addUserCOD(String id) async {
      var temp = await generateOrderId();
      // DocumentReference<Map<String, dynamic>> order =

      DateTime now = DateTime.now();
      String day = now.day.toString().length == 2
          ? now.day.toString()
          : '0' + now.day.toString();
      String month = now.month.toString().length == 2
          ? now.month.toString()
          : '0' + now.month.toString();
      String hour = now.hour.toString().length == 2
          ? now.hour.toString()
          : '0' + now.hour.toString();
      String minute = now.minute.toString().length == 2
          ? now.minute.toString()
          : '0' + now.minute.toString();
      String seconds = now.second.toString().length == 2
          ? now.second.toString()
          : '0' + now.second.toString();
      String orderTime = day +
          "-" +
          month +
          "-" +
          now.year.toString().substring(2, 4) +
          "," +
          hour +
          ":" +
          minute +
          ":" +
          seconds;
      return FirebaseFirestore.instance
          .collection(orderDate)
          .doc(temp)
          .set({
            'DistributorID': id,
            'ProductList': getOrders(),
            'Status': 'Ordered',
            'Total Price': orderData.totalAmount,
            'OTP': generateOtp(),
            'PaymentType': 'COD',
            'Date': orderTime,
          })
          .then((value) => print(orderTime))
          .catchError((error) => print("$error"));
    }

    return ValueListenableBuilder<Box<UserStore>>(
      valueListenable: Boxes.getUserStore().listenable(),
      builder: (context, box, _) {
        final user = box.values.toList().cast<UserStore>();
        return SizedBox(
          width: 150,
          height: 55,
          child: ElevatedButton(
              onPressed: () {
                generateOrderId();
                addUserCOD(user.elementAt(0).id);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SucessPage()));
              },
              style: ElevatedButton.styleFrom(primary: const Color(0xff23233c)),
              child: const Text(
                'Pay using Cash on Delivery',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              )),
        );
      },
    );
  }
}

// TODO: Online button that is not needed anymore
//
//
//
// class OnlineOrderButton extends StatelessWidget {
//   const OnlineOrderButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var orderData = Provider.of<Cart>(context);
//     Map<String, CartItem> tmp = orderData.items;
//     CollectionReference order = FirebaseFirestore.instance.collection('Orders');
//     Map<String, int> orders = {};
//     Map<String, int> getOrders() {
//       for (var i in tmp.values) {
//         orders[i.id] = i.quantity;
//       }
//       return orders;
//     }

//     generateOtp() {
//       var rng = Random();
//       int rand = rng.nextInt(8888) + 1000;
//       String stringValue = rand.toString();
//       return stringValue;
//     }

//     Future<void> addUser(String id) {
//       return order
//           .add({
//             'DistributorID': id,
//             'ProductList': getOrders(),
//             'Status': 'Ordered',
//             'Total Price': orderData.totalAmount,
//             'OTP': generateOtp(),
//             'PaymentType': 'Online'
//           })
//           .then((value) => print("User Added"))
//           .catchError((error) => print("Failed to add user: $error"));
//     }

//     return ValueListenableBuilder<Box<UserStore>>(
//       valueListenable: Boxes.getUserStore().listenable(),
//       builder: (context, box, _) {
//         final user = box.values.toList().cast<UserStore>();
//         return SizedBox(
//           width: 150,
//           height: 55,
//           child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => Gateway(orderData.totalAmount,
//                             addUser(user.elementAt(0).id))));
//               },
//               style: ElevatedButton.styleFrom(primary: const Color(0xff23233c)),
//               child: const Text(
//                 'Pay Online using Razorpay',
//                 style: TextStyle(color: Colors.white),
//                 textAlign: TextAlign.center,
//               )),
//         );
//       },
//     );
//   }
// }
