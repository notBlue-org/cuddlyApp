import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('All Orders'),
      ),
      body: const Center(
        child: Text('All Orders Will Be displayed here'),
      ),
    );
  }
}
