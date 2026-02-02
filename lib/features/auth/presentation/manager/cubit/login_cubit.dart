import 'package:evently/core/helper/cache_helper.dart';
import 'package:evently/features/auth/data/repos/login_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());

  LoginRepo loginRepo;
  var formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future loginWithEmail() async {
    emit(LoginLoading());
    var response = await loginRepo.loginWithEmail(
      email: email.text,
      password: password.text,
    );
    response.fold(
      (error) {
        emit(LoginFailure(error.toString()));
      },
      (userCredential) {
        CacheHelper.saveData(key: 'token', value: userCredential.user!.uid);
        emit(LoginSuccess(userCredential.user!));
      },
    );
  }

  Future loginWithGoogle() async {
    emit(LoginLoading());
    var response = await loginRepo.loginWithGoogle();
    response.fold(
      (error) {
        if (kDebugMode) {
          print(error);
        }
        emit(LoginFailure(error));
      },
      (userCredential) {
        CacheHelper.saveData(key: 'token', value: userCredential.uid);
        emit(LoginSuccess(userCredential));
      },
    );
  }

  Future resetPassword() async {
    emit(ResetPasswordLoading());
    var response = await loginRepo.resetPassword(email: email.text);
    response.fold(
      (error) {
        if (kDebugMode) {
          print(error);
        }
        emit(ResetPasswordFailure(error));
      },
      (message) {
        emit(ResetPasswordSuccess(message));
      },
    );
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ChangePasswordVisibility());
  }

  @override
  Future<void> close() {
    email.dispose();
    password.dispose();
    return super.close();
  }
}
