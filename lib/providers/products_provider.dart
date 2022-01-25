import 'package:diaryapp/models/boxes.dart';
import 'package:diaryapp/models/user_stored.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
    List<Product> _productList = [];
    final box = Boxes.getUserStore();

    var _userDetails = box.values.toList().elementAt(0);

    var _productDocsDefault = [];
    Map _productDocsUserMap = {};

    for (var _brand in _userDetails.brands) {
      if (!_categories.contains(_brand)) {
        _categories.add(_brand);
      }

      await FirebaseFirestore.instance
          .collection(_brand)
          .get()
          .then((QuerySnapshot data) {
        _productDocsDefault = data.docs;
      });

      await FirebaseFirestore.instance
          .collection("Distributors")
          .doc(_userDetails.id)
          .collection(_brand)
          .get()
          .then((QuerySnapshot data) {
        for (var product in data.docs) {
          Map _product = product.data() as Map;
          _productDocsUserMap[product.id] = double.parse(_product["Price"]);
        }
      });

      if (_productDocsUserMap.isEmpty) {
        for (var product in _productDocsDefault) {
          Map _product = product.data() as Map;
          _productList.add(Product(
              id: product.id,
              brand: _brand,
              title: _product['Name'],
              description: _product['Description'],
              imageUrl: _product['ImageURI'],
              price: double.parse(_product['Price'])));
        }
      } else {
        for (var product in _productDocsDefault) {
          Map _product = product.data() as Map;
          if (_productDocsUserMap.containsKey(product.id)) {
            _productList.add(Product(
                id: product.id,
                brand: _brand,
                title: _product['Name'],
                description: _product['Description'],
                imageUrl: _product['ImageURI'],
                price: _productDocsUserMap[product.id]));
          } else {
            _productList.add(Product(
                id: product.id,
                brand: _brand,
                title: _product['Name'],
                description: _product['Description'],
                imageUrl: _product['ImageURI'],
                price: double.parse(_product['Price'])));
          }
        }
      }
    }

    _items = _productList;
    return _productList;
  }

  var _filterItems = [];

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
