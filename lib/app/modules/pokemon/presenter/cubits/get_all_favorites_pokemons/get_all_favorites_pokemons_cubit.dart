import 'package:bloc/bloc.dart';

import '../../../domain/params/params.dart';
import '../../../domain/use_cases/contracts/get_all_pokemons_use_case.dart';

import 'get_all_favorites_pokemons_state.dart';

class GetAllFavoritesPokemonsCubit extends Cubit<GetAllFavoritesPokemonsState> {
  final GetAllPokemonsUseCase _getAllPokemons;

  GetAllFavoritesPokemonsCubit(this._getAllPokemons)
      : super(const InitialGetAllFavoritesPokemonsState(pokemons: []));

  void getAll({bool reset = false}) async {
    if (reset) {
      emit(const InitialGetAllFavoritesPokemonsState(pokemons: []));
    }

    if (state is! LoadingGetAllFavoritesPokemonsState &&
        (state is! SuccessGetAllFavoritesPokemonsState ||
            !((state as SuccessGetAllFavoritesPokemonsState).loadLast))) {
      //
      emit(LoadingGetAllFavoritesPokemonsState(pokemons: state.pokemons));

      if (state.pokemons.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 1));
      }

      var result = await _getAllPokemons(
        params: GetAllPokemonsParams(
          offset: state.pokemons.length,
          limit: 5,
          saved: true,
        ),
      );

      result.fold((left) {
        emit(FailureGetAllFavoritesPokemonsState(
          pokemons: state.pokemons,
          error: left.message,
        ));
      }, (right) async {
        emit(SuccessGetAllFavoritesPokemonsState(
          pokemons: state.pokemons + right,
          loadLast: right.isEmpty || right.length < 5,
        ));
      });
    }
  }
}
