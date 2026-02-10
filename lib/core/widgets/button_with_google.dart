import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWithGoogle extends StatelessWidget {
  ButtonWithGoogle({super.key, required this.onTap});
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

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
            Image.asset('assets/images/google (2).png'),
            SizedBox(width: 8),
            Text(localizations.googleLogin, style: AppTextStyles.blue18Medium),
          ],
        ),
      ),
    );
  }
}
