import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class TypeHiveObject extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String image;

  @HiveField(2)
  final int colorLight;

  @HiveField(3)
  final int colorDark;

  TypeHiveObject({
    required this.name,
    required this.image,
    required this.colorLight,
    required this.colorDark,
  });
}