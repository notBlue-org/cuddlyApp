import 'package:flutter/material.dart';
import '../../providers/cart.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 8.0, left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Total Number of products ${cart.itemCount}',
                  style: const TextStyle(fontSize: 14)),
              Text('Total Bill: Rs ${cart.totalAmount}',
                  style: const TextStyle(fontSize: 14)),
              // Chip(
              //     label: Text('Payable amt \$${cart.totalAmount}'),
              //     backgroundColor: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
