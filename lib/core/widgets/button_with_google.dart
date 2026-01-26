import 'package:evently/core/constatnt/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class ButtonWithGoogle extends StatelessWidget {
  ButtonWithGoogle({super.key, required this.onTap});
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.google),
            SizedBox(width: 8),
            Text('Login with Google', style: AppTextStyles.blue18Medium),
          ],
        ),
      ),
    );
  }
}
