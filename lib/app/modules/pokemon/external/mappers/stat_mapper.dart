import '../../domain/entities/entities.dart';

import '../hive/hive.dart';

class StatMapper {
  static List<StatEntity> fromList(List list) {
    return list.map((element) => fromMap(element)).toList();
  }

  static StatEntity fromMap(Map json) {
    return StatEntity(
      name: json['stat']['name'],
      baseStat: json['base_stat'],
      effort: json['effort'],
    );
  }

  static List<StatEntity> fromHiveList(List list) {
    return list.map((element) => fromHive(element)).toList();
  }

  static StatEntity fromHive(StatHiveObject hiveObject) {
    return StatEntity(
      name: hiveObject.name,
      baseStat: hiveObject.baseStat,
      effort: hiveObject.effort,
    );
  }
}