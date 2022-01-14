import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

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
  late List<String> _categories = [];
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
        if (!_categories.contains(tmp['Company'])) {
          _categories.add(tmp['Company']);
        }
      }
    });

    _items = tmpList;
    return tmpList;
  }

  var _filterItems;
  Products() {
    getData().then((value) => _filterItems =
        _items.where((element) => element.brand == 'Malabar').toList());
  }

  void filter({String brand = 'company1'}) {
    _filterItems = _items.where((element) => element.brand == brand).toList();
    notifyListeners();
  }

  List<Product> get filterItems {
    return [..._filterItems];
  }
}
