class Prod{
  String imgUrl;
  String desc;
  String name;
  num price;
  num quantity;

  Prod(this.imgUrl,this.desc,this.name,this.price,this.quantity);


  static List<Prod> Brand1(){
    return[
      Prod(
        'assets/images/bag_1.png',
        'Best shit in town',
        'Lady bird',
        50,
        1,
      ),
      Prod(
        'assets/images/bag_2.png',
        'Best poop in town',
        'Lady Gaga',
        5,
        1,
      )
    ];
  }

  static List<Prod> Brand2(){
    return[
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