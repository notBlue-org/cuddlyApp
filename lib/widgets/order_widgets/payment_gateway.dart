// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Gateway extends StatefulWidget {
  final Future<void> addUser;
  final double total_amount;
  const Gateway(this.total_amount, this.addUser, {Key? key}) : super(key: key);
  @override
  State<Gateway> createState() => _FinalOrderState();
}

class _FinalOrderState extends State<Gateway> {
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();

    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    openCheckout();
  }

  void handlerPaymentSuccess(Future<void> addUser) {
    addUser;
  }

  void handlerErrorFailure() {
    print("Payment success");
  }

  void handlerExternalWallet() {
    print("External Wallet");
  }

  void openCheckout() async {
    var options = {
      "key": "rzp_test_QgshDg09IHVGJn",
      "amount": widget.total_amount * 100,
      "name": "Agrisoft ",
      "description": "Payment for the Diary Prodcucts You have Purchased For",
      "prefill": {"contact": "9567190733", "email": "notBlue@gmail.com"},
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
