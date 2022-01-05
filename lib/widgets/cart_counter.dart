// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, must_be_immutable, avoid_print, use_key_in_widget_constructors

import 'package:diaryapp/providers/cart_counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartCounter extends StatefulWidget {
  final id;
  CartCounter({required this.id});
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  @override
  Widget build(BuildContext context) {
    var itemData = Provider.of<CartCounterMove>(context);
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
              if (itemData.displayCount(widget.id) > 0)
                {
                  setState(() {
                    itemData.removeItem(widget.id);
                    // CartCounter(item_num: item_default);
                  }),
                }
            },
            child: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            itemData.displayCount(widget.id).toString().padLeft(2, '0'),
            style: TextStyle(
              color: Colors.white,
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
              setState(() {
                itemData.addItem(widget.id);
                // CartCounter(item_num: item_default);
              })
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
