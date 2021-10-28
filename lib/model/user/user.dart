import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  User({
    required this.uuid,
    required this.name,
    required this.age,
  });

  @HiveField(0)
  String uuid;

  @HiveField(1)
  String name;

  @HiveField(2)
  int age;

  @override
  String toString() {
    return "$name: $age";
  }
}
