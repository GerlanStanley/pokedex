import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokedex/app/core/failures/failures.dart';
import 'package:pokedex/app/modules/pokemon/domain/entities/entities.dart';
import 'package:pokedex/app/modules/pokemon/domain/params/params.dart';
import 'package:pokedex/app/modules/pokemon/domain/use_cases/contracts/get_all_pokemons_use_case.dart';
import 'package:pokedex/app/modules/pokemon/presenter/cubits/get_all_remotes_pokemons/get_all_remotes_pokemons.dart';

class MockGetAllPokemonsUseCase extends Mock implements GetAllPokemonsUseCase {}

void main() {
  late MockGetAllPokemonsUseCase useCase;
  late GetAllRemotesPokemonsCubit cubit;
  late GetAllPokemonsParams params;

  setUp(() {
    useCase = MockGetAllPokemonsUseCase();
    cubit = GetAllRemotesPokemonsCubit(useCase);
    params = const GetAllPokemonsParams(offset: 0, limit: 5, saved: false);

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
    act: (GetAllRemotesPokemonsCubit cubit) {
      cubit.getAll();
    },
    expect: () => [
      isA<LoadingGetAllRemotesPokemonsState>(),
      isA<SuccessGetAllRemotesPokemonsState>(),
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
    act: (GetAllRemotesPokemonsCubit cubit) {
      cubit.getAll();
    },
    expect: () => [
      isA<LoadingGetAllRemotesPokemonsState>(),
      isA<FailureGetAllRemotesPokemonsState>(),
    ],
  );
}
