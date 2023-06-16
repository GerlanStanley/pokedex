import 'package:equatable/equatable.dart';

class StatEntity extends Equatable {
  final String name;
  final int baseStat;
  final int effort;

  const StatEntity({
    required this.name,
    required this.baseStat,
    required this.effort,
  });

  @override
  List<Object?> get props => [name];
}
