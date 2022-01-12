import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class FinalOrder extends StatefulWidget {
  const FinalOrder({Key? key}) : super(key: key);
  @override
  _FinalOrderState createState() => _FinalOrderState();
}

class _FinalOrderState extends State<FinalOrder> {
  late Razorpay razorpay;
  int finalamount=200;
  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  void handlerPaymentSuccess(){
    print("Payment success");
    Fluttertoast.showToast(
        msg: "Payment Sucess",
    );
  }

  void handlerErrorFailure(){
    print("Payment error");

  }

  void handlerExternalWallet(){
    print("External Wallet");

  }

  void openCheckout()async{
    var options = {
      "key" : "rzp_test_QgshDg09IHVGJn",
      "amount" :finalamount*100,
      "name" : "Sample App",
      "description" : "Payment for the some random product",

      "prefill" : {
        "contact" : "2323232323",
        "email" : "shdjsdh@gmail.com"
      },

    };

    try{
      razorpay.open(options);
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Final Order Page')),
      body:
      Column(
        children: [
          SizedBox(height: 12) ,
          ElevatedButton(onPressed: (){
            openCheckout();
          },
          child: Text("paynow"),)
        ],
      ),

    );
  }
}
