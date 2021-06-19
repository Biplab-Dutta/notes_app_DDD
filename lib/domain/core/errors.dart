import 'package:notes_app/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure<String> valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const String explanation =
        'Encountered a value failure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was $valueFailure.');
  }
}
