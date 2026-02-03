part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  // Using User type to be consistent and safe, although implementations might vary
  final dynamic user;
  SignupSuccess(this.user);
}

class SignupFailure extends SignupState {
  final String error;
  SignupFailure(this.error);
}

class ChangePasswordVisibility extends SignupState {}
