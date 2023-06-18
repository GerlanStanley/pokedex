import 'package:hive/hive.dart';

import 'hive.dart';

part 'pokemon_hive_object.g.dart';

@HiveType(typeId: 1)
class PokemonHiveObject extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int height;

  @HiveField(3)
  final int weight;

  @HiveField(4)
  final int baseExperience;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final List<TypeHiveObject> types;

  @HiveField(7)
  final List<String> abilities;

  @HiveField(8)
  final List<StatHiveObject> stats;

  PokemonHiveObject({
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
}