import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/widgets/button_with_google.dart';
import 'package:evently/core/widgets/custome_button.dart';
import 'package:evently/core/widgets/custome_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Center(child: Image.asset('assets/images/app_logo.png')),
              SizedBox(height: 48),
              Text(
                'Login to your account',
                style: AppTextStyles.blue24SemiBold,
              ),
              SizedBox(height: 24),
              CustomeTextField(
                _validateLogin,
                text: 'Enter your email',
                isPassword: false,
                controller: loginController,
                prefixIcon: Icon(Icons.email_outlined),
              ),
              SizedBox(height: 16),
              CustomeTextField(
                _validatePassword,
                text: 'Enter your password',
                isPassword: true,
                controller: passwordController,
                prefixIcon: Icon(Icons.lock_outline),
              ),
              Row(
                mainAxisAlignment: .end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot password?',
                      style: AppTextStyles.blue14SemiBold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 47),
              CustomeButton(
                title: 'Login',
                backgroundColor: AppColors.blue,
                ontap: () {},
                textColor: AppColors.white,
              ),
              SizedBox(height: 48),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    'Don’t have an account ?',
                    style: AppTextStyles.blue14Regular.copyWith(
                      color: AppColors.grey,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Signup',
                      style: AppTextStyles.blue14Regular.copyWith(
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48),

              ButtonWithGoogle(onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
