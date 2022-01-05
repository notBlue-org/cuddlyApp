import 'package:flutter/foundation.dart';

class CartCounterMove with ChangeNotifier {
  num _count = 0;

  num get value {
    return _count;
  }

  void increment() {
    _count += 1;
    notifyListeners();
  }

  void decrement() {
    _count -= 1;
    notifyListeners();
  }
}
