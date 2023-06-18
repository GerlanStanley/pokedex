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

  Future<Either<Failure, bool>> save({required PokemonEntity pokemon});

  Future<Either<Failure, bool>> delete({required PokemonEntity pokemon});

  Future<Either<Failure, bool>> isFavorite({required PokemonEntity pokemon});
}
