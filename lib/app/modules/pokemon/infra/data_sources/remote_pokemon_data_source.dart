import '../../domain/entities/entities.dart';
import '../../domain/params/params.dart';

abstract class RemotePokemonDataSource {
  Future<List<PokemonResumedEntity>> getAll({
    required GetAllPokemonsParams params,
  });
}
