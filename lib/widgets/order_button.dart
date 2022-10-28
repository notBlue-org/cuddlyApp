import 'package:diaryapp/models/user_stored.dart';
import 'package:diaryapp/models/boxes.dart';
import 'package:diaryapp/providers/cart_provider.dart';
import 'package:diaryapp/widgets/order_widgets/payment_gateway.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class OnlineOrderButton extends StatelessWidget {
  const OnlineOrderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<UserStore>>(
      valueListenable: Boxes.getUserStore().listenable(),
      builder: (context, box, _) {
        var orderData = Provider.of<Cart>(context);
        Map<String, CartItem> tmp = orderData.items;
        CollectionReference order =
            FirebaseFirestore.instance.collection('Orders');
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

        Future<void> addUser(String id) async {
          var number;
          await FirebaseFirestore.instance
              .collection('Distributors')
              .doc(id)
              .update({'AmountDue': orderData.totalAmount.toString()}).then(
                  (value) => order
                      .add({
                        'DistributorID': id,
                        'ProductList': getOrders(),
                        'Status': 'Ordered',
                        'Total Price':
                            (number + orderData.totalAmount).toString(),
                        'OTP': generateOtp(),
                        'PaymentType': 'Online',
                        'Date': DateTime.now(),
                      })
                      .then((value) => print("User Added"))
                      .catchError((error) => ("Failed to add user: $error")));
        }

        final user = box.values.toList().cast<UserStore>();
        return SizedBox(
          width: 150,
          height: 55,
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Gateway(orderData.totalAmount[0],
                            addUser(user.elementAt(0).id))));
              },
              style: ElevatedButton.styleFrom(primary: const Color(0xff23233c)),
              child: const Text(
                'Pay Online using Razorpay',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              )),
        );
      },
    );
  }
}
