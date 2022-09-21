import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

class OrderHistoryDetailsPage extends StatelessWidget {
  final objectData;
  const OrderHistoryDetailsPage(this.objectData, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const NavDrawer(),
        appBar: custAppBar("Order Details"),
        body: OrderHistoryDetailsPageBody(objectData));
  }
}

class OrderHistoryDetailsPageBody extends StatefulWidget {
  final objectData;
  const OrderHistoryDetailsPageBody(this.objectData, {Key? key})
      : super(key: key);

  @override
  State<OrderHistoryDetailsPageBody> createState() =>
      OrderHistoryDetailsPageBodyState();
}

class OrderHistoryDetailsPageBodyState
    extends State<OrderHistoryDetailsPageBody> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(children: [
      SizedBox(
          height: 150,
          child: Stack(children: [Positioned(top: 0, child: CustomWaveSvg())])),
      SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(left: 10.0),
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(13, 21, 129, 0.03),
                    blurRadius: 100.0,
                    offset: Offset(0, 10.0),
                    spreadRadius: 2,
                  ),
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.5,
                      child: const Text(
                        "Order ID",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(widget.objectData.id),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.5,
                      child: const Text(
                        "OTP",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(widget.objectData.otp),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.5,
                      child: const Text(
                        "Payment Type",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(widget.objectData.paymentType),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.5,
                      child: const Text(
                        "Total Price",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(widget.objectData.totalPrice.toString()),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.5,
                      child: const Text(
                        "Status",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(widget.objectData.status),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: const Text(
                        "Product List",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, i) =>
                      OrderHistoryProductItem(widget.objectData.productList[i]),
                  itemCount: widget.objectData.productList.length,
                  scrollDirection: Axis.vertical,
                ),
              ],
            )),
      )
    ]);
  }
}

class OrderHistoryProductItem extends StatelessWidget {
  final Map productDetailsMap;
  const OrderHistoryProductItem(this.productDetailsMap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width * 0.3,
              child: const Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(productDetailsMap["Name"]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width * 0.3,
              child: const Text(
                "Quantity",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(productDetailsMap["Quantity"].toString()),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width * 0.3,
              child: const Text(
                "Price",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(productDetailsMap["Price"].toString()),
          ],
        ),
        const SizedBox(height: 10),
      ]),
    );
  }
}
