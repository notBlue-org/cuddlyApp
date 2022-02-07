import 'package:diaryapp/constants/colors.dart';
import 'package:diaryapp/providers/products_provider.dart';
import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:diaryapp/widgets/order_widgets/product_item.dart';
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

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
            height: 150,
            child:
                Stack(children: [Positioned(top: 0, child: CustomWaveSvg())])),
        const FutureProductGrid(),
      ],
    );
  }
}

class FutureProductGrid extends StatefulWidget {
  const FutureProductGrid({Key? key}) : super(key: key);

  @override
  State<FutureProductGrid> createState() => _FutureProductGridState();
}

class _FutureProductGridState extends State<FutureProductGrid> {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return FutureBuilder(
      future: productData.getData(),
      builder: (
        BuildContext context,
        AsyncSnapshot snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {
          return const ProductList();
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // late int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    var productList = productData.filterItems;
    var categories = productData.categories;
    int selectedIndex = productData.selectedIndex;

    return Expanded(
      child: Column(children: [
        Container(
          margin: const EdgeInsets.all(8),
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => {
                setState(() {
                  productData.updateIndex(index);
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
                  color: index == selectedIndex ? kPrimaryColor : kButtonColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  categories[index],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (ctx, index) => ProductItem(
              id: productList[index].id,
              title: productList[index].title,
              imageUrl: productList[index].imageUrl,
              price: productList[index].price,
              description: productList[index].description,
              brand: productList[index].brand,
            ),
            padding: const EdgeInsets.all(10),
            itemCount: productList.length,
            scrollDirection: Axis.vertical,
          ),
        ),
      ]),
    );
  }
}
