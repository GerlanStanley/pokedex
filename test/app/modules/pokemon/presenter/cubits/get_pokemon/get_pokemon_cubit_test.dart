import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/app/core/failures/failures.dart';
import 'package:pokedex/app/modules/pokemon/domain/entities/entities.dart';
import 'package:pokedex/app/modules/pokemon/domain/params/params.dart';
import 'package:pokedex/app/modules/pokemon/domain/use_cases/contracts/get_pokemon_use_case.dart';
import 'package:pokedex/app/modules/pokemon/presenter/cubits/get_pokemon/get_pokemon.dart';

class MockGetPokemonUseCase extends Mock implements GetPokemonUseCase {}

void main() {
  late MockGetPokemonUseCase useCase;
  late GetPokemonCubit cubit;
  late GetPokemonParams params;
  late PokemonEntity pokemon;

  setUp(() {
    useCase = MockGetPokemonUseCase();
    cubit = GetPokemonCubit(useCase);
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

  tearDown(() {
    cubit.close();
  });

  blocTest(
    "Quando o useCase retornar um sucesso o "
    "bloc deve iniciar carregando e terminar com sucesso",
    build: () {
      when(() => useCase.call(params: any(named: "params"))).thenAnswer(
        (_) async => Right<Failure, PokemonEntity>(pokemon),
      );
      return cubit;
    },
    act: (GetPokemonCubit cubit) {
      cubit.get('bulbasaur');
    },
    expect: () => [
      isA<LoadingGetPokemonState>(),
      isA<SuccessGetPokemonState>(),
    ],
  );

  blocTest(
    "Quando o useCase retornar uma falha o "
    "bloc deve iniciar carregando e terminar com falha",
    build: () {
      when(() => useCase.call(params: any(named: "params"))).thenAnswer(
        (_) async => Left<Failure, PokemonEntity>(Failure(message: "")),
      );
      return cubit;
    },
    act: (GetPokemonCubit cubit) {
      cubit.get('bulbasaur');
    },
    expect: () => [
      isA<LoadingGetPokemonState>(),
      isA<FailureGetPokemonState>(),
    ],
  );
}
