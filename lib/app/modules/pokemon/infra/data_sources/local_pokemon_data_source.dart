import '../../domain/entities/entities.dart';

abstract class LocalPokemonDataSource {
  Future<List<PokemonResumedEntity>> getAll();

  Future<bool> save({required PokemonEntity pokemon});

  Future<bool> delete({required PokemonEntity pokemon});
}
