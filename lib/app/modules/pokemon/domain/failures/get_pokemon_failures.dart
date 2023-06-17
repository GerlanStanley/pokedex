import '../../../../core/failures/failures.dart';

class GetPokemonNameFailure extends Failure {
  GetPokemonNameFailure({
    required String message,
    StackTrace? stackTrace,
  }) : super(message: message, stackTrace: stackTrace);
}