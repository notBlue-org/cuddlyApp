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
        Map productMap = product.data() as Map;
        if (productMap.containsKey(customPriceKey)) {
          price = double.parse(productMap[customPriceKey]);
        } else {
          price = double.parse(productMap['Price']);
        }
        productList.add(Product(
            id: product.id,
            brand: brand,
            title: productMap['Name'],
            description: productMap['Description'],
            imageUrl: productMap['ImageURI'],
            price: (price).roundToDouble()));
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
