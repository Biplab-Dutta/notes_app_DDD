import 'package:dartz/dartz.dart';
import 'package:notes_app/domain/auth/auth_failure.dart';
import 'package:notes_app/domain/auth/value_objects.dart';

// ignore: lines_longer_than_80_chars
// ! This class is similar to repository in the domain layer of CLEAN Architecture
// ! Here we are only speciying the contracts.

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
