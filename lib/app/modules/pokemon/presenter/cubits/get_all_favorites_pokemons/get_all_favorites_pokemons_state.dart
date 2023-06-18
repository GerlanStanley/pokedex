import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';

abstract class GetAllFavoritesPokemonsState extends Equatable {
  final List<PokemonResumedEntity> pokemons;

  const GetAllFavoritesPokemonsState({
    required this.pokemons,
  });
}

class InitialGetAllFavoritesPokemonsState extends GetAllFavoritesPokemonsState {
  const InitialGetAllFavoritesPokemonsState({
    required List<PokemonResumedEntity> pokemons,
  }) : super(pokemons: pokemons);

  @override
  List<Object> get props => [];
}

class LoadingGetAllFavoritesPokemonsState extends GetAllFavoritesPokemonsState {
  const LoadingGetAllFavoritesPokemonsState({
    required List<PokemonResumedEntity> pokemons,
  }) : super(pokemons: pokemons);

  @override
  List<Object> get props => [];
}

class SuccessGetAllFavoritesPokemonsState extends GetAllFavoritesPokemonsState {
  final bool loadLast;

  const SuccessGetAllFavoritesPokemonsState({
    required List<PokemonResumedEntity> pokemons,
    required this.loadLast,
  }) : super(pokemons: pokemons);

  @override
  List<Object> get props => [];
}

class FailureGetAllFavoritesPokemonsState extends GetAllFavoritesPokemonsState {
  final String error;

  const FailureGetAllFavoritesPokemonsState({
    required List<PokemonResumedEntity> pokemons,
    required this.error,
  }) : super(pokemons: pokemons);

  @override
  List<Object> get props => [error];
}
