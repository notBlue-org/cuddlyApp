import 'package:flutter/material.dart';
import '../providers/cart.dart';

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total', style: TextStyle(fontSize: 14)),
            Text('Number of products ${cart.itemCount}',
                style: const TextStyle(fontSize: 14)),
            Chip(
                label: Text('\$${cart.totalAmount}'),
                backgroundColor: Theme.of(context).primaryColor),
            ElevatedButton(
                onPressed: () => {},
                child: const Text(
                  'Order now',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
