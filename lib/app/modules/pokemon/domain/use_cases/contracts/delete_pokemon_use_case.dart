import 'package:dartz/dartz.dart';

import '../../../../../core/failures/failures.dart';

import '../../entities/entities.dart';

abstract class DeletePokemonUseCase {
  Future<Either<Failure, bool>> call({
    required PokemonEntity pokemon,
  });
}
