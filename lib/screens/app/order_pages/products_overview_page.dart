
import 'package:diaryapp/providers/cart.dart';
import 'package:diaryapp/providers/products_provider.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:diaryapp/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('New Order'),
        actions: [
          Consumer<Cart>(
            builder: (context, value, child) => IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => {
                Navigator.of(context).pushNamed('/cart_page'),
              },
            ),
          )
        ],
      ),
      body: const ProductGrid(),
    );
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

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
