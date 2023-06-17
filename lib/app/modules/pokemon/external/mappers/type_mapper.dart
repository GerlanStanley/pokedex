import '../../domain/entities/entities.dart';

import '../hive/hive.dart';

class TypeMapper {
  static List<TypeEntity> fromList(List list) {
    return list.map((element) => fromMap(element)).toList();
  }

  static TypeEntity fromMap(Map json) {
    return TypeEntity(
      name: json['type']['name'],
      color: _types[json['type']['name']]!.color,
      image: _types[json['type']['name']]!.image,
    );
  }

  static List<TypeEntity> fromHiveList(List list) {
    return list.map((element) => fromHive(element)).toList();
  }

  static TypeEntity fromHive(TypeHiveObject hiveObject) {
    return TypeEntity(
      name: hiveObject.name,
      image: hiveObject.image,
      color: hiveObject.color,
    );
  }

  static List<TypeHiveObject> toHiveList(List list) {
    return list.map((element) => toHive(element)).toList();
  }

  static TypeHiveObject toHive(TypeEntity entity) {
    return TypeHiveObject(
      name: entity.name,
      image: entity.image,
      color: entity.color,
    );
  }
}

class Type {
  final int color;
  final String image;

  Type({
    required this.color,
    required this.image,
  });
}

Map<String, Type> _types = {
  'normal': Type(
    color: 1,
    image: 'teste',
  ),
  "fighting": Type(
    color: 1,
    image: 'teste',
  ),
  "flying": Type(
    color: 1,
    image: 'teste',
  ),
  "poison": Type(
    color: 1,
    image: 'teste',
  ),
  "ground": Type(
    color: 1,
    image: 'teste',
  ),
  "rock": Type(
    color: 1,
    image: 'teste',
  ),
  "bug": Type(
    color: 1,
    image: 'teste',
  ),
  "ghost": Type(
    color: 1,
    image: 'teste',
  ),
  "steel": Type(
    color: 1,
    image: 'teste',
  ),
  "fire": Type(
    color: 1,
    image: 'teste',
  ),
  "water": Type(
    color: 1,
    image: 'teste',
  ),
  "grass": Type(
    color: 1,
    image: 'teste',
  ),
  "electric": Type(
    color: 1,
    image: 'teste',
  ),
  "psychic": Type(
    color: 1,
    image: 'teste',
  ),
  "ice": Type(
    color: 1,
    image: 'teste',
  ),
  "dragon": Type(
    color: 1,
    image: 'teste',
  ),
  "dark": Type(
    color: 1,
    image: 'teste',
  ),
  "fairy": Type(
    color: 1,
    image: 'teste',
  ),
  "unknown": Type(
    color: 1,
    image: 'teste',
  ),
  "shadow": Type(
    color: 1,
    image: 'teste',
  ),
};
