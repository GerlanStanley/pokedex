import '../../../../core/failures/failures.dart';

class GetAllPokemonsLimitFailure extends Failure {
  GetAllPokemonsLimitFailure({
    required String message,
    StackTrace? stackTrace,
  }) : super(message: message, stackTrace: stackTrace);
}

class GetAllPokemonsOffsetFailure extends Failure {
  GetAllPokemonsOffsetFailure({
    required String message,
    StackTrace? stackTrace,
  }) : super(message: message, stackTrace: stackTrace);
}