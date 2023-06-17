import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';

abstract class GetAllRemotesPokemonsState extends Equatable {
  final List<PokemonResumedEntity> pokemons;

  const GetAllRemotesPokemonsState({
    required this.pokemons,
  });
}

class InitialGetAllRemotesPokemonsState extends GetAllRemotesPokemonsState {
  const InitialGetAllRemotesPokemonsState({
    required List<PokemonResumedEntity> pokemons,
  }) : super(pokemons: pokemons);

  @override
  List<Object> get props => [];
}

class LoadingGetAllRemotesPokemonsState extends GetAllRemotesPokemonsState {
  const LoadingGetAllRemotesPokemonsState({
    required List<PokemonResumedEntity> pokemons,
  }) : super(pokemons: pokemons);

  @override
  List<Object> get props => [];
}

class SuccessGetAllRemotesPokemonsState extends GetAllRemotesPokemonsState {
  final bool loadLast;

  const SuccessGetAllRemotesPokemonsState({
    required List<PokemonResumedEntity> pokemons,
    required this.loadLast,
  }) : super(pokemons: pokemons);

  @override
  List<Object> get props => [];
}

class FailureGetAllRemotesPokemonsState extends GetAllRemotesPokemonsState {
  final String error;

  const FailureGetAllRemotesPokemonsState({
    required List<PokemonResumedEntity> pokemons,
    required this.error,
  }) : super(pokemons: pokemons);

  @override
  List<Object> get props => [error];
}
