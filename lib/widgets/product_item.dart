// ignore_for_file: avoid_print
import 'package:diaryapp/widgets/cart_counter.dart';
import 'package:diaryapp/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;

  ProductItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
  });
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return GridTile(
      child: Image.network(imageUrl, fit: BoxFit.fill),
      footer: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTileBar(
          leading: CartCounter(),
          trailing: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add_to_photos),
                color: Colors.white,
                onPressed: () => {cart.addItem(id, price, title)},
              ),
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                color: Colors.white,
                onPressed: () => {},
              ),
            ],
          ),
          backgroundColor: Colors.black87,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
