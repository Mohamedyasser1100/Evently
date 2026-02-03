import 'package:evently/features/auth/data/repos/signup_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.signupRepo) : super(SignupInitial());

  final SignupRepo signupRepo;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ChangePasswordVisibility());
  }

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text != confirmPassController.text) {
        emit(SignupFailure("Passwords do not match!"));
        return;
      }

      emit(SignupLoading());

      final response = await signupRepo.signupWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        confirmPass: confirmPassController.text.trim(),
      );

      response.fold(
        (error) => emit(SignupFailure(error)),
        (userCredential) => emit(SignupSuccess(userCredential.user)),
      );
    }
  }

  Future<void> signupWithGoogle() async {
    emit(SignupLoading());
    final response = await signupRepo.signupWithGoogle();

    response.fold(
      (error) => emit(SignupFailure(error)),
      (user) => emit(SignupSuccess(user)),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    return super.close();
  }
}
