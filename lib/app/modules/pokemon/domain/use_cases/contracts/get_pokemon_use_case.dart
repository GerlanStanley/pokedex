import 'package:dartz/dartz.dart';

import '../../../../../core/failures/failures.dart';

import '../../entities/entities.dart';
import '../../params/params.dart';

abstract class GetPokemonUseCase {
  Future<Either<Failure, PokemonEntity>> call({
    required GetPokemonParams params,
  });
}
