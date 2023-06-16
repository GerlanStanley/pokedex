import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class TypeHiveObject extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String image;

  @HiveField(2)
  final int color;

  TypeHiveObject({
    required this.name,
    required this.image,
    required this.color,
  });
}