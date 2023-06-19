import 'package:bloc/bloc.dart';

import '../../../domain/params/params.dart';
import '../../../domain/use_cases/contracts/get_all_pokemons_use_case.dart';

import 'get_all_remotes_pokemons_state.dart';

class GetAllRemotesPokemonsCubit extends Cubit<GetAllRemotesPokemonsState> {
  final GetAllPokemonsUseCase _getAllPokemons;

  GetAllRemotesPokemonsCubit(this._getAllPokemons)
      : super(const InitialGetAllRemotesPokemonsState(pokemons: []));

  void getAll() async {
    if (state is! LoadingGetAllRemotesPokemonsState &&
        (state is! SuccessGetAllRemotesPokemonsState ||
            !((state as SuccessGetAllRemotesPokemonsState).loadLast))) {
      //
      emit(LoadingGetAllRemotesPokemonsState(pokemons: state.pokemons));

      var result = await _getAllPokemons(
        params: GetAllPokemonsParams(
          offset: state.pokemons.length,
          limit: 10,
          saved: false,
        ),
      );

      result.fold((left) {
        emit(FailureGetAllRemotesPokemonsState(
          pokemons: state.pokemons,
          error: left.message,
        ));
      }, (right) async {
        emit(SuccessGetAllRemotesPokemonsState(
          pokemons: state.pokemons + right,
          loadLast: right.isEmpty || right.length < 5,
        ));
      });
    }
  }
}
