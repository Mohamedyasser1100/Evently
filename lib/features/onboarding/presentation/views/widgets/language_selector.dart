import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return Row(
          children: [
            Text("Language", style: AppTextStyles.blue18Medium),
            const Spacer(),
            _buildOption(
              context: context,
              label: "English",
              languageCode: 'en',
              isSelected: locale.languageCode == 'en',
            ),
            _buildOption(
              context: context,
              label: "Arabic",
              languageCode: 'ar',
              isSelected: locale.languageCode == 'ar',
            ),
          ],
        );
      },
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required String label,
    required String languageCode,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => context.read<LanguageCubit>().changeLanguage(languageCode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
