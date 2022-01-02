// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_constructors_in_immutables

import 'package:diaryapp/constants/colors.dart';
import 'package:diaryapp/models/Prod.dart';
import 'package:diaryapp/models/cart_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class diaryItem extends StatelessWidget {
  final Prod prod;
  diaryItem(this.prod);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(5),
                width: 110,
                height: 110,
                child: Image.asset(prod.imgUrl, fit: BoxFit.fitHeight)),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          prod.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined, size: 15),
                      ],
                    ),
                    Text(prod.desc,
                        style: TextStyle(color: kPrimaryColor, height: 1.5)),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          '\$',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '${prod.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        CartCounter(prod.quantity)
                      ],
                    )
                  ]),
            ))
          ],
        ));
  }
}
