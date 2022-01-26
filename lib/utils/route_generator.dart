import 'package:diaryapp/screens/app/home_page.dart';
import 'package:diaryapp/screens/app/order_pages/cart_page.dart';
import 'package:diaryapp/screens/app/order_pages/order_page.dart';
import 'package:diaryapp/screens/login_page.dart';
import 'package:diaryapp/screens/app/order_history_page.dart';
import 'package:diaryapp/screens/app/profile_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home_page':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/order_page':
        return MaterialPageRoute(builder: (_) => const OrderPage());
      case '/order_history_page':
        return MaterialPageRoute(builder: (_) => const OrderHistoryPage());
      case '/cart_page':
        return MaterialPageRoute(builder: (_) => const CartPage());
      case '/profile_page':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case '/login_page':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
