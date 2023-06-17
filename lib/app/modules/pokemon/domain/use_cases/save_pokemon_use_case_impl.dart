import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

import '../entities/entities.dart';
import '../repositories/pokemon_repository.dart';

import 'contracts/save_pokemon_use_case.dart';

class SavePokemonUseCaseImpl implements SavePokemonUseCase {
  final PokemonRepository _repository;

  SavePokemonUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call({
    required PokemonEntity pokemon,
  }) async {
    return await _repository.save(pokemon: pokemon);
  }
}
