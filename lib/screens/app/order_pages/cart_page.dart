import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/models/user_stored.dart';
import 'package:diaryapp/providers/brand.dart';
import 'package:diaryapp/providers/cart_provider.dart';
import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/order_widgets/cart_item.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/order_widgets/order_button.dart';
import 'package:diaryapp/widgets/order_widgets/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

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
                OnlineOrderButton(),
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
    Map<String, CartItem> tmp = orderData.items;
    CollectionReference order = FirebaseFirestore.instance.collection('Orders');
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

    Future<void> addUserCOD(String id) {
      return order
          .add({
            'DistributorID': id,
            'ProductList': getOrders(),
            'Status': 'Ordered',
            'Total Price': orderData.totalAmount,
            'OTP': generateOtp(),
            'PaymentType': 'COD',
            'Date': DateTime.now(),
          })
          .then((value) => print("User Added by COD"))
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
                addUserCOD(user.elementAt(0).id);
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
