import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/core/widgets/button_with_google.dart';
import 'package:evently/core/widgets/custome_button.dart';
import 'package:evently/core/widgets/custome_textfield.dart';
import 'package:evently/features/auth/data/repos/signup_repo_impl.dart';
import 'package:evently/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(SignupRepoImpl(FirebaseAuth.instance)),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Success! Account created."),
                backgroundColor: Colors.green,
              ),
            );
            GoRouter.of(context).go(AppRoute.loginScreen);
          } else if (state is SignupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<SignupCubit>();
          final isLoading = state is SignupLoading;

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
                          'Create your account',
                          style: AppTextStyles.blue24SemiBold,
                        ),
                        const SizedBox(height: 24),
                        CustomeTextField(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          prefixIcon: Image.asset('assets/images/user.png'),
                          text: 'Enter your name',
                          isPassword: false,
                          controller: cubit.nameController,
                        ),
                        const SizedBox(height: 16),
                        CustomeTextField(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          prefixIcon: Image.asset('assets/images/sms.png'),
                          text: 'Enter your email',
                          isPassword: false,
                          controller: cubit.emailController,
                        ),
                        const SizedBox(height: 16),
                        CustomeTextField(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          prefixIcon: Image.asset('assets/images/lock.png'),
                          suffixIcon: IconButton(
                            icon: Icon(cubit.suffix),
                            onPressed: cubit.changePasswordVisibility,
                          ),
                          text: 'Enter your password',
                          isPassword: cubit.isPassword,
                          controller: cubit.passwordController,
                        ),
                        const SizedBox(height: 16),
                        CustomeTextField(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != cubit.passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          prefixIcon: Image.asset('assets/images/lock.png'),
                          text: 'Confirm your password',
                          isPassword: cubit.isPassword,
                          controller: cubit.confirmPassController,
                        ),
                        const SizedBox(height: 52),
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : CustomeButton(
                                title: 'Sign Up',
                                backgroundColor: AppColors.blue,
                                ontap: () {
                                  cubit.signUp();
                                },
                                textColor: AppColors.white,
                              ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account ?',
                              style: AppTextStyles.blue14Regular.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                GoRouter.of(context).push(AppRoute.loginScreen);
                              },
                              child: Text(
                                ' Login',
                                style: AppTextStyles.blue14Regular.copyWith(
                                  color: AppColors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 72),
                        ButtonWithGoogle(
                          onTap: () {
                            cubit.signupWithGoogle();
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
