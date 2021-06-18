import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/domain/core/errors.dart';
import 'package:notes_app/domain/core/failures.dart';
import 'package:notes_app/domain/core/value_validators.dart';

class EmailAddress extends Equatable {
  final Either<ValueFailure<String>, String> value;
  factory EmailAddress(String input) =>
      EmailAddress._(validateEmailAddress(input));

  const EmailAddress._(this.value);

  bool isValid() => value.isRight();

  String getOrCrash() {
    return value.fold(
      (error) => throw UnexpectedValueError(error),
      (success) => success,
    );
  }

  @override
  List<Object> get props => [value];
}

class Password extends Equatable {
  final Either<ValueFailure<String>, String> value;
  factory Password(String input) => Password._(validatePassword(input));

  const Password._(this.value);

  bool isValid() => value.isRight();

  String getOrCrash() {
    return value.fold(
      (error) => throw UnexpectedValueError(error),
      (success) => success,
    );
  }

  @override
  List<Object> get props => [value];
}
