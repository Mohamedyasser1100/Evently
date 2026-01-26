import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/widgets/custome_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forgot Password'),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 32),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/change-setting.png',
                height: 343,
                width: 343,
              ),
            ),
            SizedBox(height: 40),
            CustomeButton(
              title: 'Reset Password',
              backgroundColor: AppColors.blue,
              ontap: () {},
              textColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
