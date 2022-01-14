import 'package:diaryapp/constants/colors.dart';
import 'package:diaryapp/providers/cart.dart';
import 'package:diaryapp/providers/products_provider.dart';
import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
// import 'package:diaryapp/widgets/filter_widget.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:diaryapp/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const NavDrawer(),
      appBar: custAppBar("New Order"),
      body: const ProductGrid(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/cart_page');
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

class ProductGrid extends StatefulWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  int selectedIndex = 0;
  List categories = [
    'company1',
    'company2',
    'company3',
    'company4',
    'company5',
  ];
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    var productList = productData.filterItems;
    return Column(children: [
      CustomWaveSvg(),
      Container(
        margin: const EdgeInsets.all(8),
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => {
              setState(() {
                selectedIndex = index;
                productData.filter(brand: categories[index]);
              })
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                left: 10,
                // At end item it add extra 20 right  padding
                right: index == categories.length - 1 ? 10 : 0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: index == selectedIndex ? Colors.pink : Colors.lightBlue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                categories[index],
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
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
        ),
      ),
    ]);
  }
}
