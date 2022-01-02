// ignore_for_file: non_constant_identifier_names, file_names

class Prod {
  String imgUrl;
  String desc;
  String name;
  num price;
  num quantity;

  Prod(this.imgUrl, this.desc, this.name, this.price, this.quantity);

  static List<Prod> Brand1() {
    return [
      Prod(
        'assets/images/bag_1.png',
        'Product 1 descp',
        'Product 1',
        50,
        0,
      ),
      Prod(
        'assets/images/bag_2.png',
        'Product 2 descp',
        'Product 2',
        5,
        0,
      )
    ];
  }

  static List<Prod> Brand2() {
    return [
      Prod(
        'assets/images/bag_3.png',
        'Best shit in town',
        'Lady bird',
        50,
        1,
      ),
      Prod(
        'assets/images/bag_4.png',
        'Best shit in town',
        'Lady bird',
        50,
        1,
      )
    ];
  }
}
