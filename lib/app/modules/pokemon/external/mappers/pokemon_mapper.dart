import '../../domain/entities/entities.dart';

import '../hive/hive.dart';

import 'mappers.dart';

class PokemonMapper {
  static List<PokemonResumedEntity> resumedFromList(List list) {
    return list.map((element) => resumedFromMap(element)).toList();
  }

  static PokemonResumedEntity resumedFromMap(Map json) {
    return PokemonResumedEntity(
      name: json['name'],
      types: TypeMapper.fromList(json['types']),
    );
  }

  static PokemonEntity fromMap(Map json) {
    return PokemonEntity(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      image: json['sprites']['other']['home']['front_default'],
      baseExperience: json['base_experience'],
      abilities: json['abilities']
          .map((element) => element['ability']['name'])
          .toList()
          .cast<String>(),
      types: TypeMapper.fromList(json['types']),
      stats: StatMapper.fromList(json['stats']),
    );
  }

  static List<PokemonResumedEntity> resumedFromHiveList(List list) {
    return list.map((element) => resumedFromHive(element)).toList();
  }

  static PokemonResumedEntity resumedFromHive(PokemonHiveObject hiveObject) {
    return PokemonResumedEntity(
      name: hiveObject.name,
      types: TypeMapper.fromHiveList(hiveObject.types),
    );
  }

  static List<PokemonEntity> fromHiveList(List list) {
    return list.map((element) => fromHive(element)).toList();
  }

  static PokemonEntity fromHive(PokemonHiveObject hiveObject) {
    return PokemonEntity(
      id: hiveObject.id,
      name: hiveObject.name,
      height: hiveObject.height,
      weight: hiveObject.weight,
      image: hiveObject.image,
      baseExperience: hiveObject.baseExperience,
      abilities: hiveObject.abilities,
      types: TypeMapper.fromHiveList(hiveObject.types),
      stats: StatMapper.fromHiveList(hiveObject.stats),
    );
  }

  static PokemonHiveObject toHive(PokemonEntity entity) {
    return PokemonHiveObject(
      id: entity.id,
      name: entity.name,
      height: entity.height,
      weight: entity.weight,
      image: entity.image,
      baseExperience: entity.baseExperience,
      abilities: entity.abilities,
      types: TypeMapper.toHiveList(entity.types),
      stats: StatMapper.toHiveList(entity.stats),
    );
  }
}
