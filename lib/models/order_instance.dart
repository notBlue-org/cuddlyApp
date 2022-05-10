class OrderInstance {
  final String id;
  final String paymentType;
  final String otp;
  final Map productList;
  final String status;
  final double totalPrice;

  OrderInstance(
      {required this.id,
      required this.paymentType,
      required this.otp,
      required this.productList,
      required this.status,
      required this.totalPrice});
}
