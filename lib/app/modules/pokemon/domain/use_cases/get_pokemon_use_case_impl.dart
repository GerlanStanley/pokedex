import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

import '../entities/entities.dart';
import '../failures/get_pokemon_failures.dart';
import '../params/params.dart';
import '../repositories/pokemon_repository.dart';

import 'contracts/get_pokemon_use_case.dart';

class GetPokemonUseCaseImpl implements GetPokemonUseCase {
  final PokemonRepository _repository;

  GetPokemonUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, PokemonEntity>> call({
    required GetPokemonParams params,
  }) async {
    if (params.name.trim().isEmpty) {
      return Left(GetPokemonNameFailure(
        message: "Name is empty",
      ));
    }

    return await _repository.get(params: params);
  }
}
