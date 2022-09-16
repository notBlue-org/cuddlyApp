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
            .then((QuerySnapshot data) {
          for (var product in data.docs) {
            Map productMap = product.data() as Map;
            var price = double.parse(productMap['Price']);
            var tax = double.parse(productMap['Tax']);
            var final_price = ((tax / 100) * price) + price;
            // print(final_price);
            productDocsUserMap[product.id] = final_price;
          }
        });
      });

      if (productDocsUserMap.isEmpty) {
        for (var product in productDocsDefault) {
          Map productMap = product.data() as Map;
          productList.add(Product(
              id: product.id,
              brand: brand,
              title: productMap['Name'],
              description: productMap['Description'],
              imageUrl: productMap['ImageURI'],
              price: (((double.parse(productMap['Tax']) / 100) *
                          double.parse(productMap['Price'])) +
                      double.parse(productMap['Price']))
                  .roundToDouble()));
        }
      } else {
        for (var product in productDocsDefault) {
          Map productMap = product.data() as Map;
          if (productDocsUserMap.containsKey(product.id)) {
            productList.add(Product(
                id: product.id,
                brand: brand,
                title: productMap['Name'],
                description: productMap['Description'],
                imageUrl: productMap['ImageURI'],
                price: productDocsUserMap[product.id]));
          } else {
            productList.add(Product(
                id: product.id,
                brand: brand,
                title: productMap['Name'],
                description: productMap['Description'],
                imageUrl: productMap['ImageURI'],
                price: double.parse(productMap['Price'])));
          }
        }
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
