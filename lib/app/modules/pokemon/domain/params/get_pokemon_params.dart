import 'package:equatable/equatable.dart';

class GetPokemonParams extends Equatable {
  final String name;

  const GetPokemonParams({
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}