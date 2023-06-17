import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/entities.dart';
import '../../domain/params/params.dart';
import '../../infra/data_sources/local_pokemon_data_source.dart';

import '../hive/hive.dart';
import '../mappers/pokemon_mapper.dart';

class LocalPokemonDataSourceImpl implements LocalPokemonDataSource {
  final Box box;
  final key = 'pokemonList';

  LocalPokemonDataSourceImpl(this.box);

  @override
  Future<List<PokemonResumedEntity>> getAll({
    required GetAllPokemonsParams params,
  }) async {
    List<PokemonHiveObject> results = box.get(key) ?? [];

    results = results.sublist(params.offset, params.limit);

    return PokemonMapper.resumedFromHiveList(results);
  }

  @override
  Future<PokemonEntity?> get({
    required GetPokemonParams params,
  }) async {
    List<PokemonHiveObject> results = box.get(key) ?? [];

    var result =
        results.firstWhereOrNull((element) => element.name == params.name);

    return result != null ? PokemonMapper.fromHive(result) : null;
  }

  @override
  Future<bool> delete({required PokemonEntity pokemon}) async {
    List<PokemonHiveObject> results = box.get(key) ?? [];

    results.removeWhere((element) => element.id == pokemon.id);

    await box.put(key, results);

    return true;
  }

  @override
  Future<bool> save({required PokemonEntity pokemon}) async {
    List<PokemonHiveObject> results = box.get(key) ?? [];

    var result =
        results.firstWhereOrNull((element) => element.id == pokemon.id);

    if (result == null) {
      results.add(PokemonMapper.toHive(pokemon));
    }

    await box.put(key, results);

    return true;
  }
}
