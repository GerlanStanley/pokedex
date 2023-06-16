import '../../domain/entities/entities.dart';

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
}