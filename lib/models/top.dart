
import 'Prod.dart';

class Diary {
  late String name;


  Map<String, List<Prod>> menu;

  Diary(this.name, this.menu);

  static Diary generateDiary() {
    return Diary(
      'SHOP',
      {
        'Recommend': Prod.Brand1(),
        'Popular': Prod.Brand2(),
        'Myr': [],
        'Ommfi': [],
      },
    );
  }
}