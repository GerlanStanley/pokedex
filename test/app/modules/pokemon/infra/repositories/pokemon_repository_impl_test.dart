import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/app/core/failures/failures.dart';

import 'package:pokedex/app/modules/pokemon/domain/entities/entities.dart';
import 'package:pokedex/app/modules/pokemon/domain/params/params.dart';
import 'package:pokedex/app/modules/pokemon/infra/data_sources/local_pokemon_data_source.dart';
import 'package:pokedex/app/modules/pokemon/infra/data_sources/remote_pokemon_data_source.dart';
import 'package:pokedex/app/modules/pokemon/infra/repositories/pokemon_repository_impl.dart';

class MockRemotePokemonDataSource extends Mock
    implements RemotePokemonDataSource {}

class MockLocalPokemonDataSource extends Mock
    implements LocalPokemonDataSource {}

void main() {
  late MockRemotePokemonDataSource remoteDataSource;
  late MockLocalPokemonDataSource localDataSource;
  late PokemonRepositoryImpl repository;
  late PokemonResumedEntity pokemon;

  setUp(() {
    remoteDataSource = MockRemotePokemonDataSource();
    localDataSource = MockLocalPokemonDataSource();
    repository = PokemonRepositoryImpl(remoteDataSource, localDataSource);

    pokemon = const PokemonResumedEntity(
      name: 'bulbasaur',
      types: [
        TypeEntity(
          name: 'grass',
          image: 'assets/images',
          color: 0xFFFFFFFF,
        ),
      ],
    );

    registerFallbackValue(const GetAllPokemonsParams(
      limit: 10,
      offset: 0,
      saved: false,
    ));
    registerFallbackValue(pokemon);
  });

  group('GetAll', () {
    test(
      'Deve retornar uma List<PokemonEntity> quando o local datasource retornar a lista',
      () async {
        var params = const GetAllPokemonsParams(
          limit: 10,
          offset: 0,
          saved: true,
        );

        when(() => localDataSource.getAll()).thenAnswer((_) async => [pokemon]);

        var result = await repository.getAll(params: params);

        expect(result.fold(id, id), isA<List<PokemonResumedEntity>>());
      },
    );

    test(
      'Deve retornar uma List<PokemonEntity> quando o remote datasource retornar a lista',
      () async {
        var params = const GetAllPokemonsParams(
          limit: 10,
          offset: 0,
          saved: false,
        );

        when(
          () => remoteDataSource.getAll(params: any(named: 'params')),
        ).thenAnswer((_) async => [pokemon]);

        var result = await repository.getAll(params: params);

        expect(result.fold(id, id), isA<List<PokemonResumedEntity>>());
      },
    );

    test(
      "Deve retornar um Failure quando o local datasource throws Failure",
      () async {
        var params = const GetAllPokemonsParams(
          limit: 10,
          offset: 0,
          saved: true,
        );

        when(() => localDataSource.getAll()).thenThrow(Failure(message: ""));

        var result = await repository.getAll(params: params);

        expect(result.fold(id, id), isA<Failure>());
      },
    );

    test(
      "Deve retornar um Failure quando o remote datasource throws Failure",
      () async {
        var params = const GetAllPokemonsParams(
          limit: 10,
          offset: 0,
          saved: false,
        );

        when(
          () => remoteDataSource.getAll(params: any(named: 'params')),
        ).thenThrow(Failure(message: ""));

        var result = await repository.getAll(params: params);

        expect(result.fold(id, id), isA<Failure>());
      },
    );
  });

  /*test(
    "Deve retornar uma bool quando o datasource salvar e retornar bool",
    () async {
      when(() => localDataSource.save(user: any(named: 'user')))
          .thenAnswer((_) async => true);

      var result = await repository.save(user: user);

      expect(result.fold(id, id), isA<bool>());
    },
  );

  test(
    "Deve retornar um Failure quando o datasource throws Failure",
    () async {
      when(() => localDataSource.save(user: any(named: 'user')))
          .thenThrow(Failure(message: ""));

      var result = await repository.save(user: user);

      expect(result.fold(id, id), isA<Failure>());
    },
  );

  test(
    "Deve retornar uma bool quando o datasource deletar e retornar bool",
    () async {
      when(() => localDataSource.delete(user: any(named: 'user')))
          .thenAnswer((_) async => true);

      var result = await repository.delete(user: user);

      expect(result.fold(id, id), isA<bool>());
    },
  );

  test(
    "Deve retornar um Failure quando o datasource throws Failure",
    () async {
      when(() => localDataSource.delete(user: any(named: 'user')))
          .thenThrow(Failure(message: ""));

      var result = await repository.delete(user: user);

      expect(result.fold(id, id), isA<Failure>());
    },
  );*/
}
