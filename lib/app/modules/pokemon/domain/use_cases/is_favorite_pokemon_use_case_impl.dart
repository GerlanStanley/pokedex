import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

import '../entities/entities.dart';
import '../repositories/pokemon_repository.dart';

import 'contracts/is_favorite_pokemon_use_case.dart';

class IsFavoritePokemonUseCaseImpl implements IsFavoritePokemonUseCase {
  final PokemonRepository _repository;

  IsFavoritePokemonUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call({
    required PokemonEntity pokemon,
  }) async {
    return await _repository.isFavorite(pokemon: pokemon);
  }
}
