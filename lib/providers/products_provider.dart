import 'package:flutter/foundation.dart';

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
  final List<Product> _items = [
    Product(
      id: 'p1',
      brand: 'company1',
      title: 'Red Shirt',
      description: '1 box 100 items',
      price: 29.00,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      brand: 'company1',
      title: 'Trousers',
      description: '1 box 100 items.',
      price: 59.00,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      brand: 'company1',
      title: 'Yellow Scarf',
      description: '1 box 50 items',
      price: 19.00,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      brand: 'company1',
      title: 'A Pan',
      description: '1 box 80 items.',
      price: 49.00,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
