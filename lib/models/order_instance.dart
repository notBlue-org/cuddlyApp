class OrderInstance {
  final String otp;
  final Map productList;
  final String status;
  final double totalPrice;

  OrderInstance(
      {required this.otp,
      required this.productList,
      required this.status,
      required this.totalPrice});
}
