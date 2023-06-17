import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/app/core/failures/failures.dart';
import 'package:pokedex/app/modules/pokemon/domain/entities/entities.dart';
import 'package:pokedex/app/modules/pokemon/domain/failures/get_pokemon_failures.dart';
import 'package:pokedex/app/modules/pokemon/domain/params/params.dart';
import 'package:pokedex/app/modules/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/app/modules/pokemon/domain/use_cases/get_pokemon_use_case_impl.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late MockPokemonRepository repository;
  late GetPokemonUseCaseImpl useCase;
  late GetPokemonParams params;
  late PokemonEntity pokemon;

  setUp(() {
    repository = MockPokemonRepository();
    useCase = GetPokemonUseCaseImpl(repository);
    params = const GetPokemonParams(name: 'bulbasaur');

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

    registerFallbackValue(params);
  });

  test(
    'Deve retornar um Right(PokemonEntity) quando o repository '
    'retornar um Right(PokemonEntity)',
    () async {
      when(
        () => repository.get(params: any(named: "params")),
      ).thenAnswer((_) async => Right<Failure, PokemonEntity>(pokemon));

      var result = await useCase(params: params);

      expect(result.fold(id, id), isA<PokemonEntity>());
    },
  );

  test(
    'Deve retornar um Left(GetPokemonNameFailure) '
    'quando o nome passado for vazio',
    () async {
      var params = const GetPokemonParams(name: '');

      var result = await useCase(params: params);

      expect(result.fold(id, id), isA<GetPokemonNameFailure>());
    },
  );

  test(
    'Deve retornar um Left(Failure) quando o repository '
    'retornar um Left(Failure)',
    () async {
      when(
        () => repository.get(params: any(named: 'params')),
      ).thenAnswer((_) async {
        return Left<Failure, PokemonEntity>(
          Failure(message: ""),
        );
      });

      var result = await useCase(params: params);

      expect(result.fold(id, id), isA<Failure>());
    },
  );
}
