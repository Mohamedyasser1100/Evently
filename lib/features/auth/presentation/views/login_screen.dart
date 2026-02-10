import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/core/widgets/button_with_google.dart';
import 'package:evently/core/widgets/custome_button.dart';
import 'package:evently/core/widgets/custome_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:evently/features/auth/presentation/manager/cubit/login_cubit.dart';
import 'package:evently/features/auth/data/repos/login_repo_impl.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  String? _validateLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your login';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => LoginCubit(LoginRepoImpl(FirebaseAuth.instance)),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            GoRouter.of(context).go(AppRoute.navigationScreen);
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          } else if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ResetPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();
          final isLoading =
              state is LoginLoading || state is ResetPasswordLoading;

          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.offWhite,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Form(
                  key: cubit.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Center(
                          child: Image.asset('assets/images/app_logo.png'),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          localizations.loginHeaderMessage,
                          style: AppTextStyles.blue24SemiBold,
                        ),
                        const SizedBox(height: 24),
                        CustomeTextField(
                          _validateLogin,
                          text: localizations.emailHint,
                          isPassword: false,
                          controller: cubit.email,
                          prefixIcon: Image.asset('assets/images/sms.png'),
                        ),
                        const SizedBox(height: 16),
                        CustomeTextField(
                          _validatePassword,
                          text: localizations.passwordHint,
                          isPassword: cubit.isPassword,
                          controller: cubit.password,
                          prefixIcon: Image.asset('assets/images/lock.png'),
                          suffixIcon: IconButton(
                            icon: Icon(cubit.suffix),
                            onPressed: cubit.changePasswordVisibility,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                cubit.resetPassword();
                              },
                              child: Text(
                                localizations.forgetPassword,
                                style: AppTextStyles.blue14SemiBold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 47),
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : CustomeButton(
                                title: localizations.login,
                                backgroundColor: AppColors.blue,
                                ontap: () {
                                  if (cubit.formKey.currentState!.validate()) {
                                    cubit.loginWithEmail();
                                  }
                                },
                                textColor: AppColors.white,
                              ),
                        const SizedBox(height: 48),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              localizations.dontHaveAccount,
                              style: AppTextStyles.blue14Regular.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                GoRouter.of(
                                  context,
                                ).push(AppRoute.signupScreen);
                              },
                              child: Text(
                                localizations.signUp,
                                style: AppTextStyles.blue14Regular.copyWith(
                                  color: AppColors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 48),
                        ButtonWithGoogle(
                          onTap: () {
                            cubit.loginWithGoogle();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
