// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';

class CartCounter extends StatefulWidget {
  num item;
  // ignore: use_key_in_widget_constructors
  CartCounter(this.item);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  late num item_default = widget.item;

  @override
  Widget build(BuildContext context) {
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
              if (item_default > 0)
                {
                  setState(() {
                    item_default--;
                    // print(widget.item);
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
            item_default.toString().padLeft(2, '0'),
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
                item_default++;
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
