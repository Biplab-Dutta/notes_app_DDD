import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:notes_app/domain/auth/i_auth_facade.dart';
import 'package:notes_app/domain/auth/value_objects.dart';

@Injectable(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  FirebaseAuthFacade(this._firebaseAuth, this._googleSignIn);

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressString = emailAddress.getOrCrash();
    final passwordString = password.getOrCrash();

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddressString,
        password: passwordString,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(
          const AuthFailure.emailAlreadyInUse(),
        );
      } else {
        return left(
          const AuthFailure.serverError(),
        );
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressString = emailAddress.getOrCrash();
    final passwordString = password.getOrCrash();

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressString,
        password: passwordString,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return left(
          const AuthFailure.invalidEmailAndPassword(),
        );
      } else {
        return left(
          const AuthFailure.serverError(),
        );
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser;
      googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(
          const AuthFailure.cancelledByUser(),
        );
      }
      final googleAuth = await googleUser.authentication;
      final authCredentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await _firebaseAuth.signInWithCredential(authCredentials);
      return right(unit);
    } on PlatformException catch (_) {
      return left(
        const AuthFailure.serverError(),
      );
    }
  }
}
