import 'package:diaryapp/widgets/FinalOrder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class OrderButton extends StatelessWidget {
  const OrderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderData = Provider.of<Cart>(context);
    Map<String, CartItem> tmp = orderData.items;
    CollectionReference order = FirebaseFirestore.instance.collection('Orders');
    Map<String, int> orders = {};
    Map<String, int> getOrders() {
      for (var i in tmp.values) {
        orders[i.id] = i.quantity;
      }
      return orders;
    }

    Otp(){
      var rng = new Random();
      int  rand = rng.nextInt(8888)+1000 ;
      String stringValue = rand.toString();
      return stringValue;
    }

    Future<void> addUser() {
      return order
          .add({
            'ProductList': getOrders(),
            'Status': 'Ordered',
            'Total Price': orderData.totalAmount,
            'OTP': Otp(),
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FinalOrder(orderData.totalAmount,addUser())));
        },
        child: const Text(
          'Order now',
          style: TextStyle(color: Colors.white),
        ));
  }
}
