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
  late PokemonResumedEntity pokemonResumed;
  late PokemonEntity pokemon;

  setUp(() {
    remoteDataSource = MockRemotePokemonDataSource();
    localDataSource = MockLocalPokemonDataSource();
    repository = PokemonRepositoryImpl(remoteDataSource, localDataSource);

    pokemonResumed = const PokemonResumedEntity(
      id: 1,
      name: 'bulbasaur',
      image: 'image',
      types: [
        TypeEntity(
          name: 'grass',
          image: 'assets/images',
          colorLight: 0xFFFFFFFF,
          colorDark: 0xFFFFFFFF,
        ),
      ],
    );

    pokemon = const PokemonEntity(
      id: 1,
      name: 'bulbasaur',
      height: 1,
      weight: 1,
      image: 'image',
      baseExperience: 1,
      abilities: [],
      stats: [],
      types: [
        TypeEntity(
          name: 'grass',
          image: 'assets/images',
          colorLight: 0xFFFFFFFF,
          colorDark: 0xFFFFFFFF,
        ),
      ],
    );

    registerFallbackValue(const GetAllPokemonsParams(
      limit: 10,
      offset: 0,
      saved: false,
    ));

    registerFallbackValue(const GetPokemonParams(name: 'bulbasaur'));

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

        when(
          () => localDataSource.getAll(params: any(named: 'params')),
        ).thenAnswer((_) async => [pokemonResumed]);

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
        ).thenAnswer((_) async => [pokemonResumed]);

        var result = await repository.getAll(params: params);

        expect(result.fold(id, id), isA<List<PokemonResumedEntity>>());
      },
    );

    test(
      'Deve retornar um Failure quando o local datasource throws Failure',
      () async {
        var params = const GetAllPokemonsParams(
          limit: 10,
          offset: 0,
          saved: true,
        );

        when(
          () => localDataSource.getAll(params: any(named: 'params')),
        ).thenThrow(Failure(message: ""));

        var result = await repository.getAll(params: params);

        expect(result.fold(id, id), isA<Failure>());
      },
    );

    test(
      'Deve retornar um Failure quando o remote datasource throws Failure',
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

  group('Get', () {
    test(
      'Deve retornar um PokemonEntity quando o local datasource retornar o objeto',
      () async {
        var params = const GetPokemonParams(name: 'bulbasaur');

        when(
          () => localDataSource.get(params: params),
        ).thenAnswer((_) async => pokemon);

        var result = await repository.get(params: params);

        expect(result.fold(id, id), isA<PokemonEntity>());
      },
    );

    test(
      'Deve retornar um PokemonEntity quando o remote datasource retornar o objeto',
      () async {
        var params = const GetPokemonParams(name: 'bulbasaur');

        when(
          () => localDataSource.get(params: params),
        ).thenAnswer((_) async => null);

        when(
          () => remoteDataSource.get(params: params),
        ).thenAnswer((_) async => pokemon);

        var result = await repository.get(params: params);

        expect(result.fold(id, id), isA<PokemonEntity>());
      },
    );

    test(
      'Deve retornar um Failure quando o local datasource throws Failure',
      () async {
        var params = const GetPokemonParams(name: 'bulbasaur');

        when(
          () => localDataSource.get(params: any(named: 'params')),
        ).thenThrow(Failure(message: ""));

        var result = await repository.get(params: params);

        expect(result.fold(id, id), isA<Failure>());
      },
    );

    test(
      'Deve retornar um Failure quando o remote datasource throws Failure',
      () async {
        var params = const GetPokemonParams(name: 'bulbasaur');

        when(
          () => localDataSource.get(params: any(named: 'params')),
        ).thenThrow(Failure(message: ""));

        var result = await repository.get(params: params);

        expect(result.fold(id, id), isA<Failure>());
      },
    );
  });

  group('Save', () {
    test(
      'Deve retornar uma bool quando o local datasource salvar e retornar bool',
      () async {
        when(() => localDataSource.save(pokemon: any(named: 'pokemon')))
            .thenAnswer((_) async => true);

        var result = await repository.save(pokemon: pokemon);

        expect(result.fold(id, id), isA<bool>());
      },
    );

    test(
      'Deve retornar um Failure quando o local datasource throws Failure',
      () async {
        when(() => localDataSource.save(pokemon: any(named: 'pokemon')))
            .thenThrow(Failure(message: ""));

        var result = await repository.save(pokemon: pokemon);

        expect(result.fold(id, id), isA<Failure>());
      },
    );
  });

  group('Delete', () {
    test(
      "Deve retornar uma bool quando o datasource deletar e retornar bool",
      () async {
        when(() => localDataSource.delete(pokemon: any(named: 'pokemon')))
            .thenAnswer((_) async => true);

        var result = await repository.delete(pokemon: pokemon);

        expect(result.fold(id, id), isA<bool>());
      },
    );

    test(
      "Deve retornar um Failure quando o datasource throws Failure",
      () async {
        when(() => localDataSource.delete(pokemon: any(named: 'pokemon')))
            .thenThrow(Failure(message: ""));

        var result = await repository.delete(pokemon: pokemon);

        expect(result.fold(id, id), isA<Failure>());
      },
    );
  });
}
