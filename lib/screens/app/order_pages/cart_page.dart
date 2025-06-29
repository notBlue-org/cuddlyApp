import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/models/user_stored.dart';
import 'package:diaryapp/providers/cart_provider.dart';
import 'package:diaryapp/screens/app/success_pages/success_page.dart';
import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/order_widgets/cart_item.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/order_widgets/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
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
    String day =
        now.day.toString().length == 2 ? now.day.toString() : '0${now.day}';
    String month = now.month.toString().length == 2
        ? now.month.toString()
        : '0${now.month}';
    String orderDate =
        'Orders_$day-$month-${now.year.toString().substring(2, 4)}';

    Map<String, CartItem> tmp = orderData.items;
    var orders = [];
    var crates = 0;
    List<Object> getOrders() {
      for (var i in tmp.values) {
        orders.add({
          "ProductID": i.id,
          'Brand': i.brand,
          "Name": i.title,
          "Quantity": i.quantity,
          "Price": i.price,
          "Price_no_tax": i.price_no_tax,
          "Description": i.desciption,
          "PacketCount": i.quantity * int.parse(i.PacketCount)
        });
        [i.quantity, i.brand];
        crates = crates + i.quantity;
      }
      return [orders, crates];
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

      String day =
          now.day.toString().length == 2 ? now.day.toString() : '0${now.day}';
      String month = now.month.toString().length == 2
          ? now.month.toString()
          : '0${now.month}';
      String time = now.year.toString().substring(2, 4) + month + day;
      String orderIdString;
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        final box = Boxes.getUserStore();
        final isB2b = box.values.toList().elementAt(0).isB2B;
        if (isB2b) {
          var orderIdInt = int.parse(data!['B2B']) + 1;
          orderIdString = 'B2B$time${orderIdInt.toString().substring(1, 8)}';
          collection
              .doc('variable')
              .update({'B2B': orderIdInt.toString()})
              .then((_) => {})
              .catchError((error) => {});
        } else {
          var orderIdInt = int.parse(data!['B2C']) + 1;
          orderIdString = 'B2C$time${orderIdInt.toString().substring(1, 8)}';
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

    Future<void> addUserCOD(String id, String route) async {
      var temp = await generateOrderId();
      DateTime now = DateTime.now();
      String day =
          now.day.toString().length == 2 ? now.day.toString() : '0${now.day}';
      String month = now.month.toString().length == 2
          ? now.month.toString()
          : '0${now.month}';
      String hour = now.hour.toString().length == 2
          ? now.hour.toString()
          : '0${now.hour}';
      String minute = now.minute.toString().length == 2
          ? now.minute.toString()
          : '0${now.minute}';
      String seconds = now.second.toString().length == 2
          ? now.second.toString()
          : '0${now.second}';
      String orderTime =
          "$day-$month-${now.year.toString().substring(2, 4)},$hour:$minute:$seconds";
      var document = await FirebaseFirestore.instance
          .collection('Distributors')
          .doc(id)
          .get();
      Map<String, dynamic>? data = document.data();
      var amtDue = double.parse(data!['AmountDue']);
      var crateDue = int.parse(data['Crates']);
      var tempData = getOrders();
      var orders = tempData[0];
      var crates = int.parse(tempData[1].toString());
      await FirebaseFirestore.instance
          .collection('Distributors')
          .doc(id)
          .update({
        'AmountDue':
            (amtDue.toInt() + orderData.totalAmount[0].toInt()).toString(),
        'Crates': (crateDue + crates).toString()
      });

      return FirebaseFirestore.instance
          .collection(orderDate)
          .doc(temp)
          .set({
            'DistributorID': id,
            'ProductList': orders,
            'Status': 'Ordered',
            'Total Price': orderData.totalAmount[0].toInt().toString(),
            'Total Price (WO_TAX)': orderData.totalAmount[1].toInt().toString(),
            'OTP': generateOtp(),
            'PaymentType': 'COD',
            'Date': orderTime,
            'Route': route,
          })
          .then((value) => print('Order placed'))
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
              onPressed: () async {
                if (await isAfterTime() && orderData.totalAmount[0] > 0) {
                  generateOrderId();
                  addUserCOD(user.elementAt(0).id, user.elementAt(0).route);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SuccessPage()));
                } else if (orderData.totalAmount == 0.0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please add items to cart'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ordering time is over'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff23233c)),
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
