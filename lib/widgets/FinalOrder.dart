import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import './order_button.dart';

class FinalOrder extends StatefulWidget {


  FinalOrder(this.Totalamount,this.addUser) ;
  Future<void> addUser;
  double Totalamount;
  @override
  _FinalOrderState createState() => _FinalOrderState();

}

class _FinalOrderState extends State<FinalOrder> {
  late Razorpay razorpay;


  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  void handlerPaymentSuccess(Future<void> addUser){
   addUser ;

  }

  void handlerErrorFailure(){
    print("Payment success");

  }

  void handlerExternalWallet(){
    print("External Wallet");

  }

  void openCheckout()async{
    var options = {
      "key" : "rzp_test_QgshDg09IHVGJn",
      "amount" :widget.Totalamount*100,
      "name" : "Agrisoft ",
      "description" : "Payment for the Diary Prodcucts You have Purchased For",

      "prefill" : {
        "contact" : "9567190733",
        "email" : "notBlue@gmail.com"
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