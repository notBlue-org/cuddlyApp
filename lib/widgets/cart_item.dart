// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItemWid extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String imgUrl;
  final String desciption;

  CartItemWid({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
    required this.productId,
    this.imgUrl = 'www.google.com',
    required this.desciption,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).deleteItem(productId);
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImgHolder(imgUrl: imgUrl),
                Expanded(
                  child: ItemDetails(title: title, desciption: desciption),
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Items',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: DispItemCount(quantity: quantity),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DispItemCount extends StatelessWidget {
  const DispItemCount({
    Key? key,
    required this.quantity,
  }) : super(key: key);

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          const SizedBox(
            width: 42.0,
            height: 42.0,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(0xff23233c)),
            ),
          ),
          Text(
            quantity.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
        alignment: Alignment.center,
      ),
    );
  }
}

class ItemDetails extends StatelessWidget {
  const ItemDetails({
    Key? key,
    required this.title,
    required this.desciption,
  }) : super(key: key);

  final String title;
  final String desciption;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            desciption,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

class ImgHolder extends StatelessWidget {
  const ImgHolder({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 110,
        height: double.infinity,
        child: Image.network(
          imgUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
