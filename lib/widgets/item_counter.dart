// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, must_be_immutable, avoid_print, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables

import 'package:diaryapp/providers/cart_counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCounter extends StatefulWidget {
  final id;
  ItemCounter({required this.id});
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<ItemCounter> {
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
                  }),
                }
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
            itemData.displayCount(widget.id).toString().padLeft(2, '0'),
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
              setState(() {
                itemData.addItem(widget.id);
              })
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
