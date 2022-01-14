// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:ffi';

import 'package:flutter/foundation.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String brand;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Product(
      {required this.id,
      required this.brand,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price});
}

class Products with ChangeNotifier {
  late List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Future<num> getData() async {
    List<Product> tmpList = [];
    await FirebaseFirestore.instance
        .collection('Product_Specification')
        .get()
        .then((QuerySnapshot data) {
      var _productList = data.docs;
      for (var product in _productList) {
        Map tmp = product.data() as Map;
        tmpList.add(Product(
            id: product.id,
            brand: tmp['Company'],
            title: tmp['Name'],
            description: tmp['Description'],
            imageUrl: tmp['ImageURI'],
            price: double.parse(tmp['Price'])));
      }
    });
    _items = tmpList;
    return 1;
  }

  var _filterItems;
  Products() {
    var tmp = getData();
    tmp.then((value) {
      _filterItems =
          _items.where((element) => element.brand == 'Malabar').toList();
    });
  }

  void filter({String brand = 'company1'}) {
    _filterItems = _items.where((element) => element.brand == brand).toList();
    notifyListeners();
  }

  List<Product> get filterItems {
    return [..._filterItems];
  }
}
