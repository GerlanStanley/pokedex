import 'package:dartz/dartz.dart';

import '../../../../../core/failures/failures.dart';

import '../../entities/entities.dart';

abstract class IsFavoritePokemonUseCase {
  Future<Either<Failure, bool>> call({
    required PokemonEntity pokemon,
  });
}
