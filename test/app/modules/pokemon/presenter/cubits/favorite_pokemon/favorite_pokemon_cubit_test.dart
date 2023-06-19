import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/app/core/failures/failures.dart';
import 'package:pokedex/app/modules/pokemon/domain/entities/entities.dart';
import 'package:pokedex/app/modules/pokemon/domain/use_cases/contracts/delete_pokemon_use_case.dart';
import 'package:pokedex/app/modules/pokemon/domain/use_cases/contracts/is_favorite_pokemon_use_case.dart';
import 'package:pokedex/app/modules/pokemon/domain/use_cases/contracts/save_pokemon_use_case.dart';
import 'package:pokedex/app/modules/pokemon/presenter/cubits/favorite_pokemon/favorite_pokemon.dart';

class MockIsFavoritePokemonUseCase extends Mock
    implements IsFavoritePokemonUseCase {}

class MockSavePokemonUseCase extends Mock implements SavePokemonUseCase {}

class MockDeletePokemonUseCase extends Mock implements DeletePokemonUseCase {}

void main() {
  late MockIsFavoritePokemonUseCase isFavoriteUseCase;
  late MockSavePokemonUseCase saveUseCase;
  late MockDeletePokemonUseCase deleteUseCase;
  late FavoritePokemonCubit cubit;
  late PokemonEntity pokemon;

  setUp(() {
    isFavoriteUseCase = MockIsFavoritePokemonUseCase();
    saveUseCase = MockSavePokemonUseCase();
    deleteUseCase = MockDeletePokemonUseCase();
    cubit = FavoritePokemonCubit(isFavoriteUseCase, saveUseCase, deleteUseCase);

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

  tearDown(() {
    cubit.close();
  });

  group('isFavorite', () {
    blocTest(
      "Quando o useCase retornar um true o "
      "bloc deve encerrar com IsFavoriteState",
      build: () {
        when(
          () => isFavoriteUseCase.call(pokemon: any(named: "pokemon")),
        ).thenAnswer(
          (_) async => const Right<Failure, bool>(true),
        );
        return cubit;
      },
      act: (FavoritePokemonCubit cubit) {
        cubit.isFavorite(pokemon: pokemon);
      },
      expect: () => [
        isA<IsFavoriteState>(),
      ],
    );

    blocTest(
      "Quando o useCase retornar um false "
      "bloc deve encerrar com IsNotFavoriteState",
      build: () {
        when(
          () => isFavoriteUseCase.call(pokemon: any(named: "pokemon")),
        ).thenAnswer(
          (_) async => const Right<Failure, bool>(false),
        );
        return cubit;
      },
      act: (FavoritePokemonCubit cubit) {
        cubit.isFavorite(pokemon: pokemon);
      },
      expect: () => [
        isA<IsNotFavoriteState>(),
      ],
    );

    blocTest(
      "Quando o useCase retornar uma falha o "
      "bloc não deve fazer nada",
      build: () {
        when(
          () => isFavoriteUseCase.call(pokemon: any(named: "pokemon")),
        ).thenAnswer(
          (_) async => Left<Failure, bool>(Failure(message: "")),
        );
        return cubit;
      },
      act: (FavoritePokemonCubit cubit) {
        cubit.isFavorite(pokemon: pokemon);
      },
      expect: () => [],
    );
  });

  group('favorite', () {
    blocTest(
      "Quando favoritar um pokemon o retorno deve ser um único IsFavoriteState",
      build: () {
        when(
          () => saveUseCase.call(pokemon: any(named: "pokemon")),
        ).thenAnswer(
          (_) async => const Right<Failure, bool>(true),
        );
        return cubit;
      },
      act: (FavoritePokemonCubit cubit) {
        cubit.favorite(pokemon: pokemon, value: true);
      },
      expect: () => [
        isA<IsFavoriteState>(),
      ],
    );

    blocTest(
      "Quando desfavoritar um pokemon o retorno deve ser um único IsFavoriteState",
      build: () {
        when(
          () => deleteUseCase.call(pokemon: any(named: "pokemon")),
        ).thenAnswer(
          (_) async => const Right<Failure, bool>(true),
        );
        return cubit;
      },
      act: (FavoritePokemonCubit cubit) {
        cubit.favorite(pokemon: pokemon, value: false);
      },
      expect: () => [
        isA<IsNotFavoriteState>(),
      ],
    );

    blocTest(
      "Quando favoritar um pokemon e der erro o retorno deve ser inicialmente "
      "um IsFavoriteState e posteriormente IsNotFavoriteState",
      build: () {
        when(
          () => saveUseCase.call(pokemon: any(named: "pokemon")),
        ).thenAnswer(
          (_) async => Left<Failure, bool>(Failure(message: "")),
        );
        return cubit;
      },
      act: (FavoritePokemonCubit cubit) {
        cubit.favorite(pokemon: pokemon, value: true);
      },
      expect: () => [
        isA<IsFavoriteState>(),
        isA<IsNotFavoriteState>(),
      ],
    );

    blocTest(
      "Quando desfavoritar um pokemon e der erro o retorno deve ser inicialmente "
      "um IsNotFavoriteState e posteriormente IsFavoriteState",
      build: () {
        when(
          () => deleteUseCase.call(pokemon: any(named: "pokemon")),
        ).thenAnswer(
          (_) async => Left<Failure, bool>(Failure(message: "")),
        );
        return cubit;
      },
      act: (FavoritePokemonCubit cubit) {
        cubit.favorite(pokemon: pokemon, value: false);
      },
      expect: () => [
        isA<IsNotFavoriteState>(),
        isA<IsFavoriteState>(),
      ],
    );
  });
}
