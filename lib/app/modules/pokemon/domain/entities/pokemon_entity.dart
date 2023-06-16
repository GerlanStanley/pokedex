import 'package:equatable/equatable.dart';

import 'stat_entity.dart';
import 'type_entity.dart';

class PokemonEntity extends Equatable {
  final int id;
  final String name;
  final int height;
  final int weight;
  final int baseExperience;
  final String image;
  final List<TypeEntity> types;
  final List<String> abilities;
  final List<StatEntity> stats;

  const PokemonEntity({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.image,
    required this.types,
    required this.abilities,
    required this.stats,
  });

  @override
  List<Object?> get props => [id];
}
