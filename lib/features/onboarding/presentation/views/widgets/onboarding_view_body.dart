import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/core/widgets/custome_button.dart';
import 'package:evently/features/onboarding/presentation/views/widgets/language_selector.dart';
import 'package:evently/features/onboarding/presentation/views/widgets/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .center,
          children: [
            Center(child: Image.asset('assets/images/app_logo.png')),
            SizedBox(height: 24),
            Image.asset('assets/images/onboarding1.png'),
            SizedBox(height: 24),
            Text(
              'Personalize Your Experience',
              style: AppTextStyles.black20SemiBold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Choose your preferred theme and\nlanguage to get started with a\ncomfortable, tailored experience that suits\nyour style.',
              style: AppTextStyles.grey14Regular,
            ),
            SizedBox(height: 18),
            LanguageSelector(),
            SizedBox(height: 16),
            ThemeSelector(),
            SizedBox(height: 42),
            CustomeButton(
              title: "Let's Start",
              backgroundColor: AppColors.blue,
              ontap: () {
                GoRouter.of(context).push(AppRoute.onboardingDetails);
              },
              textColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
