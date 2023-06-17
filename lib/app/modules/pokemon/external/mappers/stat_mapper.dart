import '../../domain/entities/entities.dart';

import '../hive/hive.dart';

class StatMapper {
  static List<StatEntity> fromList(List list) {
    return list.map((element) => fromMap(element)).toList();
  }

  static StatEntity fromMap(Map json) {
    return StatEntity(
      name: editName(json['stat']['name']),
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

  static List<StatHiveObject> toHiveList(List list) {
    return list.map((element) => toHive(element)).toList();
  }

  static StatHiveObject toHive(StatEntity entity) {
    return StatHiveObject(
      name: entity.name,
      baseStat: entity.baseStat,
      effort: entity.effort,
    );
  }

  static String editName(String name) {
    switch (name) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'Attack';
      case 'defense':
        return 'Defense';
      case 'special-attack':
        return 'Sp. Atk';
      case 'special-defense':
        return 'Sp. Def';
      default:
        return 'Speed';
    }
  }
}
