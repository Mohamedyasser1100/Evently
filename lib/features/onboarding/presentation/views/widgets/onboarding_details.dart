import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/core/widgets/custome_button.dart';
import 'package:evently/features/onboarding/data/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingDetails extends StatefulWidget {
  const OnboardingDetails({super.key});

  @override
  State<OnboardingDetails> createState() => _OnboardingDetailsState();
}

class _OnboardingDetailsState extends State<OnboardingDetails> {
  final pages = OnboardingModel.onboardingPages;
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/app_logo.png'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              GoRouter.of(context).pushReplacement(AppRoute.loginScreen);
            },
            child: Text('Skip', style: AppTextStyles.blue14SemiBold),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: PageView.builder(
          controller: _controller,
          itemCount: pages.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            final item = pages[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  item.image,
                  height: 400,
                  width: 350,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 16),
                Text(item.title, style: AppTextStyles.black20SemiBold),
                const SizedBox(height: 8),
                Text(
                  item.subTitle!,
                  style: AppTextStyles.grey14Regular.copyWith(fontSize: 18),
                ),
                const Spacer(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: CustomeButton(
          title: _currentPage == pages.length - 1 ? "Login" : "Next",
          backgroundColor: AppColors.blue,
          textColor: AppColors.white,
          ontap: () {
            if (_currentPage == pages.length - 1) {
              GoRouter.of(context).pushReplacement(AppRoute.loginScreen);
            } else {
              _controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
      ),
    );
  }
}
