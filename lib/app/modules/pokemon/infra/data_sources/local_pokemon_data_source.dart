import '../../domain/entities/entities.dart';
import '../../domain/params/params.dart';

abstract class LocalPokemonDataSource {
  Future<List<PokemonResumedEntity>> getAll();

  Future<PokemonEntity?> get({required GetPokemonParams params});

  Future<bool> save({required PokemonEntity pokemon});

  Future<bool> delete({required PokemonEntity pokemon});
}
