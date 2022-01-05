// ignore_for_file: void_checks

import 'package:flutter/foundation.dart';

class ItemCount {
  final int count;
  ItemCount({this.count = 1});
}

class CartCounterMove with ChangeNotifier {
  late Map<String, ItemCount> stark = {};

  int displayCount(String id) {
    int value;
    if (stark.containsKey(id)) {
      value = stark[id]!.count;
      return value;
    } else {
      return 0;
    }
  }

  void addItem(String id) {
    if (stark.containsKey(id)) {
      stark.update(
          id, (existingValue) => ItemCount(count: existingValue.count + 1));
    } else {
      stark.putIfAbsent(id, () => ItemCount());
    }
  }

  void removeItem(String id) {
    if (stark.containsKey(id)) {
      stark.update(
          id, (existingValue) => ItemCount(count: existingValue.count - 1));
    }
  }
}
