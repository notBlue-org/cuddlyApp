import 'package:diaryapp/static_assets/appbar_wave.dart';
import 'package:diaryapp/widgets/cust_appbar.dart';
import 'package:diaryapp/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

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

_getField(width, label, value) {
  return [
    Container(
      padding: EdgeInsets.fromLTRB(0.1 * width, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        textAlign: TextAlign.left,
        style:
            const TextStyle(color: kButtonColor, fontWeight: FontWeight.bold),
      ),
    ),
    const SizedBox(
      height: 5,
    ),
    Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(13, 21, 129, 0.03),
                blurRadius: 100.0,
                offset: Offset(0, 10.0),
                spreadRadius: 2,
              ),
            ]),
        height: 50,
        width: 0.8 * width,
        padding: const EdgeInsets.all(15),
        child: Text(
          value,
          style: const TextStyle(color: kButtonColor),
        ))
  ];
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
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(13, 21, 129, 0.03),
                          blurRadius: 100.0,
                          offset: Offset(0, 10.0),
                          spreadRadius: 2,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 10.0),
                                child: const Text(
                                  'Order Id',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            const Spacer(),
                            Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: Text(widget.objectData.id.toString())),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 10.0),
                                child: const Text(
                                  'OTP',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            const Spacer(),
                            Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: Text(widget.objectData.otp.toString())),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 10.0),
                                child: const Text(
                                  'Payment Type',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            const Spacer(),
                            Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: Text(
                                    widget.objectData.paymentType.toString())),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 10.0),
                                child: const Text(
                                  'Total Price',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            const Spacer(),
                            Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: Text(
                                    widget.objectData.totalPrice.toString())),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 10.0),
                                child: const Text(
                                  'Status',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            const Spacer(),
                            Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child:
                                    Text(widget.objectData.status.toString())),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      // const Divider(
                      //   color: Colors.black,
                      // ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Product Details',
                    style: TextStyle(
                      color: kButtonColor,
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (ctx, i) =>
                      OrderHistoryProductItem(widget.objectData.productList[i]),
                  itemCount: widget.objectData.productList.length,
                  scrollDirection: Axis.vertical,
                ),

                // Container(
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(16.0),
                //         color: Colors.white,
                //         boxShadow: const [
                //           BoxShadow(
                //             color: Color.fromRGBO(13, 21, 129, 0.03),
                //             blurRadius: 100.0,
                //             offset: Offset(0, 10.0),
                //             spreadRadius: 2,
                //           ),
                //         ]),
                //     height: 50,
                //     width: 0.8 * width,
                //     padding: const EdgeInsets.all(15),
                //     child: Text(
                //       widget.objectData.id,
                //       style: const TextStyle(color: kButtonColor),
                //     )),

                // const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SizedBox(
                //       width: width * 0.5,
                //       child: const Text(
                //         "OTP",
                //         style: TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     Text(widget.objectData.otp),
                //   ],
                // ),
                // const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SizedBox(
                //       width: width * 0.5,
                //       child: const Text(
                //         "Payment Type",
                //         style: TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     Text(widget.objectData.paymentType),
                //   ],
                // ),
                // const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SizedBox(
                //       width: width * 0.5,
                //       child: const Text(
                //         "Total Price",
                //         style: TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     Text(widget.objectData.totalPrice.toString()),
                //   ],
                // ),
                // const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SizedBox(
                //       width: width * 0.5,
                //       child: const Text(
                //         "Status",
                //         style: TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     Text(widget.objectData.status),
                //   ],
                // ),
                // const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     SizedBox(
                //       width: width * 0.4,
                //       child: const Text(
                //         "Product List",
                //         style: TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ],
                // ),
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
      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: const Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    Container(
                        margin: const EdgeInsets.only(right: 15.0),
                        child: Text(
                          productDetailsMap['Name'],
                          style: const TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                        )),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: const Opacity(
                        opacity: 0.5,
                        child: Text(
                          'Quantity',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                        margin: const EdgeInsets.only(right: 15.0),
                        child: Text(productDetailsMap['Quantity'].toString())),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: const Opacity(
                        opacity: 0.5,
                        child: Text(
                          'Price',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                        margin: const EdgeInsets.only(right: 15.0),
                        child: Text(
                            productDetailsMap['Price'].toInt().toString())),
                  ]),
                ],
              ),
            )),
      ),
    );
  }
}
