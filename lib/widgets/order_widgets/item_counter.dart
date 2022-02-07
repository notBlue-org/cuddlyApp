// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, must_be_immutable, avoid_print, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables

import 'package:diaryapp/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCounter extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final double price;
  final String brand;
  ItemCounter(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.brand});
  @override
  @override
  Widget build(BuildContext context) {
    var itemData = Provider.of<Cart>(context);
    return Row(
      children: [
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              padding: EdgeInsets.zero,
            ),
            onPressed: () => {
              if (itemData.dispQuantity(id) > 0) {itemData.removeItem(id)}
            },
            child: const Icon(
              Icons.remove,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            itemData.dispQuantity(id).toString().padLeft(2, '0'),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              padding: EdgeInsets.zero,
            ),
            onPressed: () => {
              itemData.addItem(id, price, title, imageUrl, description, brand)
            },
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
