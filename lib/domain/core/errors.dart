import 'package:notes_app/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  UnexpectedValueError(this.valueFailure);

  final ValueFailure<String> valueFailure;
  @override
  String toString() {
    const explanation =
        'Encountered a value failure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was $valueFailure.');
  }
}
