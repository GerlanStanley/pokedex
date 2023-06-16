import 'package:equatable/equatable.dart';

import 'type_entity.dart';

class PokemonResumedEntity extends Equatable {
  final String name;
  final List<TypeEntity> types;

  const PokemonResumedEntity({
    required this.name,
    required this.types,
  });

  @override
  List<Object?> get props => [name];
}
