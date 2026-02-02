import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/core/widgets/button_with_google.dart';
import 'package:evently/core/widgets/custome_button.dart';
import 'package:evently/core/widgets/custome_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conirmPassController = TextEditingController();

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != conirmPassController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match!")),
        );
        return;
      }

      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );

        await credential.user?.updateDisplayName(nameController.text.trim());

        print("Success! Account created.");
        GoRouter.of(context).go(AppRoute.loginScreen);
      } on FirebaseAuthException catch (e) {
        String message = "An error occurred";
        if (e.code == 'weak-password') {
          message = 'The password is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'Email already exists.';
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    conirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Form(
            key: _formKey,
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
                    _validateName,
                    prefixIcon: Icon(Icons.person_2_outlined),

                    text: 'Enter your name',
                    isPassword: false,
                    controller: nameController,
                  ),
                  SizedBox(height: 16),
                  CustomeTextField(
                    _validateEmail,

                    prefixIcon: Icon(Icons.email_outlined),
                    text: 'Enter your email',
                    isPassword: false,
                    controller: emailController,
                  ),
                  SizedBox(height: 16),

                  CustomeTextField(
                    _validatePassword,

                    prefixIcon: Icon(Icons.password_outlined),
                    text: 'Enter your password',
                    isPassword: true,
                    controller: passwordController,
                  ),
                  SizedBox(height: 16),

                  CustomeTextField(
                    _validateConfirmPassword,
                    prefixIcon: Icon(Icons.password_outlined),
                    text: 'Confirm your password',
                    isPassword: true,
                    controller: conirmPassController,
                  ),
                  SizedBox(height: 52),
                  CustomeButton(
                    title: 'Sign Up',
                    backgroundColor: AppColors.blue,
                    ontap: _signUp,
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
      ),
    );
  }
}
