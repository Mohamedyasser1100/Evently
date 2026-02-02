import 'package:dartz/dartz.dart';
import 'package:evently/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignupRepo {
  Future<Either<String, UserCredential>> signupWithEmail({
    required String email,
    required String password,
    required String name,
    required String confirmPass,
  });

  Future<Either<String, User>> signupWithGoogle();
  Future<void> uploadUserData({required UserModel userModel});
}
