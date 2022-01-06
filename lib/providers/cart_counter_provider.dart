// ignore_for_file: void_checks

import 'package:flutter/foundation.dart';

class ItemCount {
  final int count;
  ItemCount({this.count = 1});
}

class CartCounterMove with ChangeNotifier {
  late Map<String, ItemCount> tempCartItem = {};

  int displayCount(String id) {
    int value;
    if (tempCartItem.containsKey(id)) {
      value = tempCartItem[id]!.count;
      return value;
    } else {
      return 0;
    }
  }

  void addItem(String id) {
    if (tempCartItem.containsKey(id)) {
      tempCartItem.update(
          id, (existingValue) => ItemCount(count: existingValue.count + 1));
    } else {
      tempCartItem.putIfAbsent(id, () => ItemCount());
    }
  }

  void removeItem(String id) {
    if (tempCartItem.containsKey(id)) {
      tempCartItem.update(
          id, (existingValue) => ItemCount(count: existingValue.count - 1));
    }
  }
}
