import '../../domain/entities/entities.dart';

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
}
