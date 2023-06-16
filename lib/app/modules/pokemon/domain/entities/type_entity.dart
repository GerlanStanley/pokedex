import 'package:equatable/equatable.dart';

class TypeEntity extends Equatable {
  final String name;
  final String image;
  final int color;

  const TypeEntity({
    required this.name,
    required this.image,
    required this.color,
  });

  @override
  List<Object?> get props => [name];
}
