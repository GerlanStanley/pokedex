import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/app/core/failures/failures.dart';
import 'package:pokedex/app/modules/pokemon/domain/entities/entities.dart';
import 'package:pokedex/app/modules/pokemon/domain/failures/get_all_pokemons_failures.dart';
import 'package:pokedex/app/modules/pokemon/domain/params/params.dart';
import 'package:pokedex/app/modules/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/app/modules/pokemon/domain/use_cases/get_all_pokemons_use_case_impl.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late MockPokemonRepository repository;
  late GetAllPokemonsUseCaseImpl useCase;
  late GetAllPokemonsParams params;

  setUp(() {
    repository = MockPokemonRepository();
    useCase = GetAllPokemonsUseCaseImpl(repository);
    params = const GetAllPokemonsParams(
      limit: 10,
      offset: 0,
      saved: false,
    );

    registerFallbackValue(params);
  });

  test(
    "Deve retornar um Right(List<PokemonEntity>) quando o repository "
    "retornar um Right(List<PokemonEntity>)",
    () async {
      when(
        () => repository.getAll(params: any(named: "params")),
      ).thenAnswer((_) async {
        List<PokemonResumedEntity> pokemons = const [
          PokemonResumedEntity(
            id: 100,
            name: "bulbasaur",
            types: [
              TypeEntity(
                name: 'grass',
                image: 'assets/images',
                color: 0xFFFFFFFF,
              ),
            ],
          )
        ];

        return Right<Failure, List<PokemonResumedEntity>>(pokemons);
      });

      var result = await useCase(params: params);

      expect(result.fold(id, id), isA<List<PokemonResumedEntity>>());
    },
  );

  test(
    "Deve retornar um Left(GetAllPokemonsLimitFailure) "
    "quando o limit for menor que 1",
    () async {
      var params = const GetAllPokemonsParams(
        limit: 0,
        offset: 0,
        saved: false,
      );

      var result = await useCase(params: params);

      expect(result.fold(id, id), isA<GetAllPokemonsLimitFailure>());
    },
  );

  test(
    "Deve retornar um Left(GetAllPokemonsLimitFailure) "
    "quando o limit for maior que 10",
    () async {
      var params = const GetAllPokemonsParams(
        limit: 11,
        offset: 0,
        saved: false,
      );

      var result = await useCase(params: params);

      expect(result.fold(id, id), isA<GetAllPokemonsLimitFailure>());
    },
  );

  test(
    "Deve retornar um Left(GetAllPokemonsOffsetFailure) "
    "quando o limit for menor que 0",
    () async {
      var params = const GetAllPokemonsParams(
        limit: 10,
        offset: -1,
        saved: false,
      );

      var result = await useCase(params: params);

      expect(result.fold(id, id), isA<GetAllPokemonsOffsetFailure>());
    },
  );

  test(
    "Deve retornar um Left(Failure) quando o repository "
    "retornar um Left(Failure)",
    () async {
      when(
        () => repository.getAll(params: any(named: 'params')),
      ).thenAnswer((_) async {
        return Left<Failure, List<PokemonResumedEntity>>(
          Failure(message: ""),
        );
      });

      var result = await useCase(params: params);

      expect(result.fold(id, id), isA<Failure>());
    },
  );
}
