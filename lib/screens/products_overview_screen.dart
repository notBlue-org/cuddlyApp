// ignore_for_file: use_key_in_widget_constructors

import 'package:diaryapp/providers/cart.dart';
import 'package:diaryapp/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/product_item.dart';
import 'package:flutter/material.dart';

// import '../models/product.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductsOverViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            child: const Icon(Icons.logout)),
        title: const Text('THE APP BAR'),
        actions: [
          Consumer<Cart>(
            builder: (context, value, child) => IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => {
                Navigator.of(context).pushNamed('/cart_screen'),
              },
            ),
          )
        ],
      ),
      body: ProductGrid(),
    );
  }
}

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final productList = productData.items;
    return ListView.builder(
      itemBuilder: (ctx, index) => ProductItem(
        id: productList[index].id,
        title: productList[index].title,
        imageUrl: productList[index].imageUrl,
        price: productList[index].price,
        description: productList[index].description,
      ),
      padding: const EdgeInsets.all(10),
      itemCount: productList.length,
      scrollDirection: Axis.vertical,
    );
  }
}
