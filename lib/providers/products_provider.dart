import 'package:diaryapp/models/boxes.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class Product {
  final String id;
  final String brand;
  final String title;
  final String description;
  final double price;
  final double price_no_tax;
  final String imageUrl;
  final String PacketCount;

  Product(
      {required this.id,
      required this.brand,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price,
      required this.price_no_tax,
      required this.PacketCount});
}

class Products with ChangeNotifier {
  late List<Product> _items = [];
  late final List<String> _categories = [];
  int _selectedIndex = 0;

  List<Product> get items {
    return [..._items];
  }

  List<String> get categories {
    return [..._categories];
  }

  int get selectedIndex => _selectedIndex;

  updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future getData() async {
    List<Product> productList = [];
    final box = Boxes.getUserStore();

    var userDetails = box.values.toList().elementAt(0);

    var productDocsDefault = [];
    Map productDocsUserMap = {};

    for (var brand in userDetails.brands) {
      if (!_categories.contains(brand)) {
        _categories.add(brand);
      }
      await FirebaseFirestore.instance
          .collection(brand)
          .get()
          .then((QuerySnapshot data) {
        productDocsDefault = data.docs;
      }).then((_) {
        FirebaseFirestore.instance
            .collection("Distributors")
            .doc(userDetails.id)
            .collection(brand)
            .get()
            .then((QuerySnapshot data) {});
      });

      var customPriceKey = 'Price_${userDetails.id}';
      for (var product in productDocsDefault) {
        var price;
        var price_no_tax;
        Map productMap = product.data() as Map;
        // if (productMap.containsKey(customPriceKey)) {
        //   if (productMap[customPriceKey].toString().isEmpty) {
        //     price = double.parse(productMap['Price']);
        //   }
        //   price = double.parse(productMap[customPriceKey]);
        // } else {

        if (!productMap.containsKey(customPriceKey) ||
            productMap[customPriceKey] == "") {
          price = double.parse(productMap['Price']) +
              (double.parse(productMap['Price']) *
                  int.parse(productMap['Tax']) /
                  100);
          price_no_tax = double.parse(productMap['Price']);
        } else {
          price = double.parse(productMap[customPriceKey]) +
              (double.parse(productMap[customPriceKey]) *
                  int.parse(productMap['Tax']) /
                  100);
          price_no_tax = double.parse(productMap[customPriceKey]);
        }

        productList.add(Product(
            id: product.id,
            brand: brand,
            title: productMap['Name'],
            description: productMap['Description'],
            imageUrl: productMap['ImageURI'],
            price: double.parse(price.toStringAsFixed(2)),
            price_no_tax: double.parse(price_no_tax.toStringAsFixed(2)),
            PacketCount: productMap['PacketCount']));
      }
    }

    _items = productList;
    return productList;
  }

  var _filterItems = [];

  Products() {
    getData().then((value) => _filterItems = _items
        .where((element) => element.brand == _categories.elementAt(0))
        .toList());
  }

  void filter({String brand = 'company1'}) {
    _filterItems = _items.where((element) => element.brand == brand).toList();
    notifyListeners();
  }

  List<Product> get filterItems {
    return [..._filterItems];
  }
}
