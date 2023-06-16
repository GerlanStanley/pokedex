import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

import '../../domain/entities/entities.dart';
import '../../domain/params/params.dart';
import '../../domain/repositories/pokemon_repository.dart';

import '../data_sources/local_pokemon_data_source.dart';
import '../data_sources/remote_pokemon_data_source.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final RemotePokemonDataSource _remoteDataSource;
  final LocalPokemonDataSource _localDataSource;

  PokemonRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Either<Failure, List<PokemonResumedEntity>>> getAll({
    required GetAllPokemonsParams params,
  }) async {
    try {
      List<PokemonResumedEntity> result;
      if (params.saved) {
        result = await _localDataSource.getAll();
      } else {
        result = await _remoteDataSource.getAll(params: params);
      }
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, PokemonEntity>> get({
    required GetPokemonParams params,
  }) async {
    try {
      PokemonEntity? result = await _localDataSource.get(params: params);

      if (result != null) {
        return Right(result);
      }

      return Right(await _remoteDataSource.get(params: params));
    } on Failure catch (e) {
      return Left(e);
    }
  }

/*@override
  Future<Either<Failure, bool>> save({required PokemonEntity pokemon}) async {
    try {
      var response = await _localDataSource.save(pokemon: pokemon);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> delete({required PokemonEntity pokemon}) async {
    try {
      var response = await _localDataSource.delete(pokemon: pokemon);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }*/
}
