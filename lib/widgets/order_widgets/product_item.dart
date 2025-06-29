// ignore_for_file: avoid_print, must_be_immutable, use_key_in_widget_constructors

// import 'package:diaryapp/widgets/item_counter.dart';
import 'package:flutter/material.dart';
// import 'package:diaryapp/providers/cart_counter_provider.dart';
import 'item_counter.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final double price;
  final double priceNoTax;
  final String brand;
  int quantity;
  final String PacketCount;

  ProductItem(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.price,
      required this.priceNoTax,
      required this.description,
      this.quantity = 0,
      required this.brand,
      required this.PacketCount});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 80,
                width: 80,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(description,
                        style: const TextStyle(
                            color: Colors.black,
                            height: 1.5,
                            overflow: TextOverflow.ellipsis)),
                    Row(
                      children: [
                        const Text(
                          'Rs ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '$price',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ItemCounter(
                    id: id,
                    title: title,
                    description: description,
                    price: price,
                    priceNoTax: priceNoTax,
                    imageUrl: imageUrl,
                    brand: brand,
                    PacketCount: PacketCount,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
