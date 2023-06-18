import 'package:hive/hive.dart';

part 'stat_hive_object.g.dart';

@HiveType(typeId: 3)
class StatHiveObject extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int baseStat;

  @HiveField(2)
  final int effort;

  StatHiveObject({
    required this.name,
    required this.baseStat,
    required this.effort,
  });
}
