import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';

abstract class GetPokemonState extends Equatable {}

class InitialGetPokemonState extends GetPokemonState {
  @override
  List<Object?> get props => [];
}

class LoadingGetPokemonState extends GetPokemonState {
  @override
  List<Object?> get props => [];
}

class SuccessGetPokemonState extends GetPokemonState {
  final PokemonEntity pokemon;

  SuccessGetPokemonState({
    required this.pokemon,
  });

  @override
  List<Object> get props => [pokemon];
}

class FailureGetPokemonState extends GetPokemonState {
  final String error;

  FailureGetPokemonState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
