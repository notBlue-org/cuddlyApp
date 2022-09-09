import 'package:hive/hive.dart';

part 'user_stored.g.dart';

@HiveType(typeId: 0)
class UserStore extends HiveObject {
  @HiveField(0)
  late String username;
  @HiveField(1)
  late String id;
  @HiveField(2)
  late String route;
  @HiveField(3)
  late String email;
  @HiveField(4)
  late List<String> brands;
  @HiveField(5)
  late bool isB2B;
}
