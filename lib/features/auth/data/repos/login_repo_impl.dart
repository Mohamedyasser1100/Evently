import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:evently/features/auth/data/model/user_model.dart';
import 'package:evently/features/auth/data/repos/login_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepoImpl extends LoginRepo {
  final FirebaseAuth auth;

  LoginRepoImpl(this.auth);

  @override
  Future<Either<String, UserCredential>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Email verification check - uncomment in production
      // if (auth.currentUser!.emailVerified) {
      //   return Right(credential);
      // } else {
      //   auth.currentUser?.sendEmailVerification();
      //   return const Left(
      //     'This email is not verified. Check your email and try again',
      //   );
      // }
      await _saveUserToFirestore(credential.user!);

      return Right(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == e.code) {
        if (kDebugMode) {
          print('>>>>>>>>>>>>>>>>>>>>>> ${e.code}');
        }
        return const Left('Wrong email or password.');
      } else {
        return Left(e.toString());
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, User>> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return const Left('No Email Selected');
      }
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = FirebaseAuth.instance.currentUser;

      // Save user data to Firestore after successful Google sign-in
      if (user != null) {
        await _saveUserToFirestore(user);
      }

      return Right(user!);
    } on FirebaseAuthException catch (e) {
      return Left(e.message.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> resetPassword({required String email}) async {
    if (email == '') {
      return const Left('Please enter your email and try again');
    }
    try {
      await auth.sendPasswordResetEmail(email: email);
      return const Right('Check your email to reset password');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left('User with this email not found');
      } else {
        return Left(e.message.toString());
      }
    } catch (err) {
      return Left(err.toString());
    }
  }

  /// Save or update user data in Firestore
  Future<void> _saveUserToFirestore(User user) async {
    try {
      final token = await user.getIdToken();

      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        // User eists - update token and last login time
        await userDoc.update({
          'token': token,
          'lastLoginAt': DateTime.now().toIso8601String(),
        });

        var data = docSnapshot.data();
        if (data != null) {
          data['token'] = token;
          data['lastLoginAt'] = DateTime.now().toIso8601String();
          UserModel.currentUser = UserModel.fromJson(data);
        }
      } else {
        final userModel = UserModel(
          id: user.uid,
          name: user.displayName ?? 'User',
          email: user.email ?? '',
          userId: user.uid,
          password: '',
          confirmPass: '',
          token: token,
          lastLoginAt: DateTime.now(),
        );

        await userDoc.set(userModel.toJson());
        UserModel.currentUser = userModel;
      }
    } catch (e) {
      print('Error saving user to Firestore: $e');
    }
  }
}
