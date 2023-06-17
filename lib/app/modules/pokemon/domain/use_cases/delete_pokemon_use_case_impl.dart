import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

import '../entities/entities.dart';
import '../repositories/pokemon_repository.dart';

import 'contracts/delete_pokemon_use_case.dart';

class DeletePokemonUseCaseImpl implements DeletePokemonUseCase {
  final PokemonRepository _repository;

  DeletePokemonUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call({
    required PokemonEntity pokemon,
  }) async {
    return await _repository.delete(pokemon: pokemon);
  }
}
