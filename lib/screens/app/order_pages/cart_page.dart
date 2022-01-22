import 'package:diaryapp/providers/cart_provider.dart';
import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/cart_item.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/order_button.dart';
import 'package:diaryapp/widgets/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: custAppBar("Cart"),
      body: Column(
        children: [
          CustomWaveSvg(),
          const Text(
            "Order Details",
            style: TextStyle(fontSize: 30),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              shrinkWrap: true,
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) => CartItemWid(
                id: cart.items.values.toList()[i].id,
                price: cart.items.values.toList()[i].price,
                quantity: cart.items.values.toList()[i].quantity,
                title: cart.items.values.toList()[i].title,
                productId: cart.items.keys.toList()[i],
                imgUrl: cart.items.values.toList()[i].imgUrl,
                desciption: cart.items.values.toList()[i].desciption,
              ),
            ),
          ),
          OrderSummary(cart: cart),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                OnlineOrderButton(),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: CoDButton(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CoDButton extends StatelessWidget {
  const CoDButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 55,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(primary: const Color(0xff23233c)),
          child: const Text(
            'Pay using Cash on Delivery',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
    );
  }
}
