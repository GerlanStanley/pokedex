import 'package:dartz/dartz.dart';

import '../../../../../core/failures/failures.dart';

import '../../entities/entities.dart';
import '../../params/params.dart';

abstract class GetAllPokemonsUseCase {
  Future<Either<Failure, List<PokemonResumedEntity>>> call({
    required GetAllPokemonsParams params,
  });
}
