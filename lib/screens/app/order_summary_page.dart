import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0.0,
        title: const Text("Order Summary"),
      ),
      body: Center(
        child: Column(
          children: [
            Positioned(
              top: -10,
              child: CustomWaveSvg(),
            ),
            const Text('All Orders Will Be displayed here'),
          ],
        ),
      ),
    );
  }
}
