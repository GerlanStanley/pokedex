import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

import '../entities/entities.dart';
import '../params/params.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<PokemonResumedEntity>>> getAll({
    required GetAllPokemonsParams params,
  });

  Future<Either<Failure, PokemonEntity>> get({
    required GetPokemonParams params,
  });
}
