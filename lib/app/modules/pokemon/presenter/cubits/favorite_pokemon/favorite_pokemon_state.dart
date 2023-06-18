import 'package:equatable/equatable.dart';

abstract class FavoritePokemonState extends Equatable {}

class InitialFavoriteState extends FavoritePokemonState {
  InitialFavoriteState();

  @override
  List<Object?> get props => [];
}

class IsFavoriteState extends FavoritePokemonState {
  IsFavoriteState();

  @override
  List<Object?> get props => [];
}

class IsNotFavoriteState extends FavoritePokemonState {
  IsNotFavoriteState();

  @override
  List<Object?> get props => [];
}