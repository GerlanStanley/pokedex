import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

import '../entities/entities.dart';
import '../failures/get_all_pokemons_failures.dart';
import '../params/params.dart';
import '../repositories/pokemon_repository.dart';

import 'contracts/get_all_pokemons_use_case.dart';

class GetAllPokemonsUseCaseImpl implements GetAllPokemonsUseCase {
  final PokemonRepository _repository;

  GetAllPokemonsUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, List<PokemonResumedEntity>>> call({
    required GetAllPokemonsParams params,
  }) async {
    if (params.limit < 1) {
      return Left(GetAllPokemonsLimitFailure(
        message: "Minimum value you can set for limit is 1",
      ));
    }

    if (params.limit > 10) {
      return Left(GetAllPokemonsLimitFailure(
        message: "Maximum value you can set for limit is 10",
      ));
    }

    if (params.offset < 0) {
      return Left(GetAllPokemonsOffsetFailure(
        message: "Minimum value you can set for offset is 0",
      ));
    }

    return await _repository.getAll(params: params);
  }
}
