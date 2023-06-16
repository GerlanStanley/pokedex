import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class StatHiveObject extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(0)
  final int baseStat;

  @HiveField(0)
  final int effort;

  StatHiveObject({
    required this.name,
    required this.baseStat,
    required this.effort,
  });
}
