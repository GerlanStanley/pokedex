import 'package:equatable/equatable.dart';

class TypeEntity extends Equatable {
  final String name;
  final String image;
  final int colorLight;
  final int colorDark;

  const TypeEntity({
    required this.name,
    required this.image,
    required this.colorLight,
    required this.colorDark,
  });

  @override
  List<Object?> get props => [name];
}
