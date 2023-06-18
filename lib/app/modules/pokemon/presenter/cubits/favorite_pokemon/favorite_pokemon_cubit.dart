import 'package:bloc/bloc.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/use_cases/contracts/delete_pokemon_use_case.dart';
import '../../../domain/use_cases/contracts/is_favorite_pokemon_use_case.dart';
import '../../../domain/use_cases/contracts/save_pokemon_use_case.dart';

import 'favorite_pokemon_state.dart';

class FavoritePokemonCubit extends Cubit<FavoritePokemonState> {
  final IsFavoritePokemonUseCase _isFavoritePokemon;
  final SavePokemonUseCase _savePokemon;
  final DeletePokemonUseCase _deletePokemon;

  FavoritePokemonCubit(
    this._isFavoritePokemon,
    this._savePokemon,
    this._deletePokemon,
  ) : super(InitialFavoriteState());

  void isFavorite({required PokemonEntity pokemon}) async {
    var result = await _isFavoritePokemon(pokemon: pokemon);

    result.fold(
      (left) {},
      (right) async {
        emit(right ? IsFavoriteState() : IsNotFavoriteState());
      },
    );
  }

  void favorite({required PokemonEntity pokemon, required bool value}) async {
    emit(value ? IsFavoriteState() : IsNotFavoriteState());

    if (value) {
      var result = await _savePokemon(pokemon: pokemon);

      result.fold(
        (left) {
          emit(!value ? IsFavoriteState() : IsNotFavoriteState());
        },
        (right) async {},
      );
    } else {
      var result = await _deletePokemon(pokemon: pokemon);

      result.fold(
        (left) {
          emit(!value ? IsFavoriteState() : IsNotFavoriteState());
        },
        (right) async {},
      );
    }
  }
}
