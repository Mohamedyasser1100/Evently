part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

class ChangePasswordVisibility extends LoginState {}

class ResetPasswordLoading extends LoginState {}

class ResetPasswordSuccess extends LoginState {
  final String message;

  ResetPasswordSuccess(this.message);
}

class ResetPasswordFailure extends LoginState {
  final String error;
  ResetPasswordFailure(this.error);
}
