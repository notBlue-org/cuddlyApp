import 'package:diaryapp/providers/cart.dart';

import '../widgets/product_item.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductsOverViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('THE APP BAR'),
        actions: [
          Consumer<Cart>(
            builder: (context, value, child) => IconButton(
              icon: Icon(Icons.shopping_cart),
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
    return GridView.builder(
      itemBuilder: (ctx, index) => ProductItem(
        id: productList[index].id,
        title: productList[index].title,
        imageUrl: productList[index].imageUrl,
        price: productList[index].price,
      ),
      padding: const EdgeInsets.all(10),
      itemCount: productList.length,
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
