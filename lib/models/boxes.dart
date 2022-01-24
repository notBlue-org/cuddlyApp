import 'package:diaryapp/hive/user_stored.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<UserStore> getUserStore() => Hive.box<UserStore>('user');
}
