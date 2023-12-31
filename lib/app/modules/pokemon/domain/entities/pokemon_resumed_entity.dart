import 'package:equatable/equatable.dart';

import 'type_entity.dart';

class PokemonResumedEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final List<TypeEntity> types;

  const PokemonResumedEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.types,
  });

  @override
  List<Object?> get props => [id, name];
}
