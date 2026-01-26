import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/core/widgets/button_with_google.dart';
import 'package:evently/core/widgets/custome_button.dart';
import 'package:evently/core/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conirmPassController = TextEditingController();

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Center(child: Image.asset('assets/images/app_logo.png')),
                SizedBox(height: 48),
                Text(
                  'Create your account',
                  style: AppTextStyles.blue24SemiBold,
                ),
                SizedBox(height: 24),
                CustomeTextField(
                  prefixIcon: Icon(Icons.person_2_outlined),
                  _validateName,
                  text: 'Enter your name',
                  isPassword: false,
                  controller: nameController,
                ),
                SizedBox(height: 16),
                CustomeTextField(
                  prefixIcon: Icon(Icons.email_outlined),
                  _validateName,
                  text: 'Enter your email',
                  isPassword: false,
                  controller: emailController,
                ),
                SizedBox(height: 16),

                CustomeTextField(
                  prefixIcon: Icon(Icons.password_outlined),
                  _validateName,
                  text: 'Enter your password',
                  isPassword: true,
                  controller: passwordController,
                ),
                SizedBox(height: 16),

                CustomeTextField(
                  prefixIcon: Icon(Icons.password_outlined),
                  _validateName,
                  text: 'Confirm your password',
                  isPassword: true,
                  controller: conirmPassController,
                ),
                SizedBox(height: 52),
                CustomeButton(
                  title: 'Sign Up',
                  backgroundColor: AppColors.blue,
                  ontap: () {},
                  textColor: AppColors.white,
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account ?',
                      style: AppTextStyles.blue14Regular.copyWith(
                        color: AppColors.grey,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(AppRoute.loginScreen);
                      },
                      child: Text(
                        'Signup',
                        style: AppTextStyles.blue14Regular.copyWith(
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 72),
                ButtonWithGoogle(onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
