import 'package:bloc/bloc.dart';

import '../../../domain/params/params.dart';
import '../../../domain/use_cases/contracts/get_pokemon_use_case.dart';

import 'get_pokemon_state.dart';

class GetPokemonCubit extends Cubit<GetPokemonState> {
  final GetPokemonUseCase _getPokemon;

  GetPokemonCubit(this._getPokemon) : super(InitialGetPokemonState());

  void get(String name) async {
    emit(LoadingGetPokemonState());

    var result = await _getPokemon(
      params: GetPokemonParams(name: name),
    );

    result.fold((left) {
      emit(FailureGetPokemonState(error: left.message));
    }, (right) async {
      emit(SuccessGetPokemonState(pokemon: right));
    });
  }
}
