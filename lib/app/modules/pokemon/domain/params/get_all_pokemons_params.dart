import 'package:equatable/equatable.dart';

class GetAllPokemonsParams extends Equatable {
  final int offset;
  final int limit;
  final bool saved;

  const GetAllPokemonsParams({
    required this.offset,
    required this.limit,
    this.saved = false,
  });

  @override
  List<Object?> get props => [offset, limit, saved];
}