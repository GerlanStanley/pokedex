import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/app/core/failures/failures.dart';
import 'package:pokedex/app/modules/pokemon/domain/entities/entities.dart';
import 'package:pokedex/app/modules/pokemon/domain/params/params.dart';
import 'package:pokedex/app/modules/pokemon/domain/use_cases/contracts/get_all_pokemons_use_case.dart';
import 'package:pokedex/app/modules/pokemon/presenter/cubits/get_all_favorites_pokemons/get_all_favorites_pokemons.dart';

class MockGetAllPokemonsUseCase extends Mock implements GetAllPokemonsUseCase {}

void main() {
  late MockGetAllPokemonsUseCase useCase;
  late GetAllFavoritesPokemonsCubit cubit;
  late GetAllPokemonsParams params;

  setUp(() {
    useCase = MockGetAllPokemonsUseCase();
    cubit = GetAllFavoritesPokemonsCubit(useCase);
    params = const GetAllPokemonsParams(offset: 0, limit: 5, saved: true);

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
        (_) async => const Right<Failure, List<PokemonResumedEntity>>([]),
      );
      return cubit;
    },
    act: (GetAllFavoritesPokemonsCubit cubit) {
      cubit.getAll();
    },
    expect: () => [
      isA<LoadingGetAllFavoritesPokemonsState>(),
      isA<SuccessGetAllFavoritesPokemonsState>(),
    ],
  );

  blocTest(
    "Quando o useCase retornar uma falha o "
    "bloc deve iniciar carregando e terminar com falha",
    build: () {
      when(() => useCase.call(params: any(named: "params"))).thenAnswer(
        (_) async => Left<Failure, List<PokemonResumedEntity>>(
          Failure(message: ""),
        ),
      );
      return cubit;
    },
    act: (GetAllFavoritesPokemonsCubit cubit) {
      cubit.getAll();
    },
    expect: () => [
      isA<LoadingGetAllFavoritesPokemonsState>(),
      isA<FailureGetAllFavoritesPokemonsState>(),
    ],
  );
}
