import 'package:pokedex/app/modules/pokemon/external/mappers/type_mapper.dart';

import '../../domain/entities/entities.dart';

class PokemonMapper {
  static List<PokemonResumedEntity> resumedFromList(List list) {
    return list.map((element) => resumedFromMap(element)).toList();
  }

  static PokemonResumedEntity resumedFromMap(Map json) {
    return PokemonResumedEntity(
      name: json['name'],
      types: TypeMapper.resumedFromList(json['types']),
    );
  }
}
