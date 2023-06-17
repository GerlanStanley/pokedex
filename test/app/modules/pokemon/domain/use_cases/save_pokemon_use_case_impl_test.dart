import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/app/core/failures/failures.dart';
import 'package:pokedex/app/modules/pokemon/domain/entities/entities.dart';
import 'package:pokedex/app/modules/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/app/modules/pokemon/domain/use_cases/save_pokemon_use_case_impl.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late MockPokemonRepository repository;
  late SavePokemonUseCaseImpl useCase;
  late PokemonEntity pokemon;

  setUp(() {
    repository = MockPokemonRepository();
    useCase = SavePokemonUseCaseImpl(repository);
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

    registerFallbackValue(pokemon);
  });

  test(
    'Deve retornar um Right(true) quando o repository '
    'retornar um Right(true)',
    () async {
      when(
        () => repository.save(pokemon: any(named: "pokemon")),
      ).thenAnswer((_) async => const Right<Failure, bool>(true));

      var result = await useCase(pokemon: pokemon);

      expect(result.fold(id, id), isA<bool>());
    },
  );

  test(
    'Deve retornar um Left(Failure) quando o repository '
    'retornar um Left(Failure)',
    () async {
      when(
        () => repository.save(pokemon: any(named: 'pokemon')),
      ).thenAnswer((_) async {
        return Left<Failure, bool>(
          Failure(message: ""),
        );
      });

      var result = await useCase(pokemon: pokemon);

      expect(result.fold(id, id), isA<Failure>());
    },
  );
}
