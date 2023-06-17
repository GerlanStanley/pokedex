import '../../domain/entities/entities.dart';

import '../hive/hive.dart';

class TypeMapper {
  static List<TypeEntity> fromList(List list) {
    return list.map((element) => fromMap(element)).toList();
  }

  static TypeEntity fromMap(Map json) {
    return TypeEntity(
      name: json['type']['name'],
      colorLight: _types[json['type']['name']]!.colorLight,
      colorDark: _types[json['type']['name']]!.colorDark,
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
      colorLight: hiveObject.colorLight,
      colorDark: hiveObject.colorDark,
    );
  }

  static List<TypeHiveObject> toHiveList(List list) {
    return list.map((element) => toHive(element)).toList();
  }

  static TypeHiveObject toHive(TypeEntity entity) {
    return TypeHiveObject(
      name: entity.name,
      image: entity.image,
      colorLight: entity.colorLight,
      colorDark: entity.colorDark,
    );
  }
}

class Type {
  final int colorLight;
  final int colorDark;
  final String image;

  Type({
    required this.colorLight,
    required this.colorDark,
    required this.image,
  });
}

Map<String, Type> _types = {
  'normal': Type(
    colorLight: 0xFF9099a1,
    colorDark: 0xFF70808f,
    image: 'assets/images/normal.png',
  ),
  "fighting": Type(
    colorLight: 0xFFce4069,
    colorDark: 0xFFc32855,
    image: 'assets/images/fighting.png',
  ),
  "flying": Type(
    colorLight: 0xFF8fa8dd,
    colorDark: 0xFF6889ce,
    image: 'assets/images/flying.png',
  ),
  "poison": Type(
    colorLight: 0xFFab6ac8,
    colorDark: 0xFF9751b6,
    image: 'assets/images/poison.png',
  ),
  "ground": Type(
    colorLight: 0xFFd97746,
    colorDark: 0xFFc56231,
    image: 'assets/images/ground.png',
  ),
  "rock": Type(
    colorLight: 0xFFc7b78b,
    colorDark: 0xFFac9861,
    image: 'assets/images/rock.png',
  ),
  "bug": Type(
    colorLight: 0xFF90c12c,
    colorDark: 0xFF74a510,
    image: 'assets/images/bug.png',
  ),
  "ghost": Type(
    colorLight: 0xFF5269ac,
    colorDark: 0xFF395195,
    image: 'assets/images/ghost.png',
  ),
  "steel": Type(
    colorLight: 0xFF5a8ea1,
    colorDark: 0xFF427689,
    image: 'assets/images/steel.png',
  ),
  "fire": Type(
    colorLight: 0xFFff9c54,
    colorDark: 0xFFd17430,
    image: 'assets/images/fire.png',
  ),
  "water": Type(
    colorLight: 0xFF4d90d5,
    colorDark: 0xFF3271b3,
    image: 'assets/images/water.png',
  ),
  "grass": Type(
    colorLight: 0xFFa2d16f,
    colorDark: 0xFF84b450,
    image: 'assets/images/grass.png',
  ),
  "electric": Type(
    colorLight: 0xFFf3d23b,
    colorDark: 0xFFd1b327,
    image: 'assets/images/electric.png',
  ),
  "psychic": Type(
    colorLight: 0xFFf97176,
    colorDark: 0xFFde595e,
    image: 'assets/images/psychic.png',
  ),
  "ice": Type(
    colorLight: 0xFF74cec0,
    colorDark: 0xFF54b5a6,
    image: 'assets/images/ice.png',
  ),
  "dragon": Type(
    colorLight: 0xFF0a6dc4,
    colorDark: 0xFF0c5ea6,
    image: 'assets/images/dragon.png',
  ),
  "dark": Type(
    colorLight: 0xFF5a5366,
    colorDark: 0xFF4c4459,
    image: 'assets/images/dark.png',
  ),
  "fairy": Type(
    colorLight: 0xFFec8fe6,
    colorDark: 0xFFbf63b9,
    image: 'assets/images/fairy.png',
  ),
  "unknown": Type(
    colorLight: 0xFFf3374a,
    colorDark: 0xFFc51e2f,
    image: 'assets/images/unknown.png',
  ),
  "shadow": Type(
    colorLight: 0xFF4a4652,
    colorDark: 0xFF403b4a,
    image: 'assets/images/shadow.png',
  ),
};
