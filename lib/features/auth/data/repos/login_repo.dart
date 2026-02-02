import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepo {
  Future<Either<String, UserCredential>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<String, User>> loginWithGoogle();
  Future<Either<String, String>> resetPassword({required String email});
}
