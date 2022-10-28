import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  int quantity;
  final String brand;
  final double price;
  final double price_no_tax;
  final String imgUrl;
  final String desciption;
  final String PacketCount;
  CartItem(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.title,
      required this.imgUrl,
      required this.desciption,
      required this.brand,
      required this.price_no_tax,
      required this.PacketCount});
}

class Cart with ChangeNotifier {
  late final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int dispQuantity(String productId) {
    int value;
    if (_items.containsKey(productId)) {
      value = _items[productId]!.quantity;
    } else {
      value = 0;
    }
    return value;
  }

  int get itemCount {
    return _items.length;
  }

  List<double> get totalAmount {
    double total = 0.0;
    double totalNoTax = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
      totalNoTax += value.price_no_tax * value.quantity;
    });
    return [total, totalNoTax];
  }

  void addItem(
      String productId,
      double price,
      double price_no_tax,
      String title,
      String imgUrl,
      String description,
      String brand,
      String PacketCount) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              price: existingCartItem.price,
              price_no_tax: existingCartItem.price_no_tax,
              quantity: existingCartItem.quantity + 1,
              title: existingCartItem.title,
              imgUrl: existingCartItem.imgUrl,
              desciption: existingCartItem.desciption,
              brand: existingCartItem.brand,
              PacketCount: existingCartItem.PacketCount));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: productId,
              price: price,
              price_no_tax: price_no_tax,
              quantity: 1,
              title: title,
              imgUrl: imgUrl,
              desciption: description,
              brand: brand,
              PacketCount: PacketCount));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              price: existingCartItem.price,
              price_no_tax: existingCartItem.price_no_tax,
              quantity: existingCartItem.quantity - 1,
              title: existingCartItem.title,
              imgUrl: existingCartItem.imgUrl,
              desciption: existingCartItem.desciption,
              brand: existingCartItem.brand,
              PacketCount: existingCartItem.PacketCount));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void deleteItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
