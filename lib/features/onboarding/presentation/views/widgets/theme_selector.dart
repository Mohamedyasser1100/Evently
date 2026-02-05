import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:flutter/material.dart';

class ThemeSelector extends StatefulWidget {
  const ThemeSelector({super.key});

  @override
  State<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  bool isDarkTheme = false;

  Widget buildOption({
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: Colors.blue),
        ),
        child: Icon(
          icon,
          color: selected ? Colors.white : AppColors.blue,
          size: 28,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Theme", style: AppTextStyles.blue18Medium),
        Spacer(),
        buildOption(
          icon: Icons.wb_sunny,
          selected: !isDarkTheme,
          onTap: () => setState(() => isDarkTheme = false),
        ),
        buildOption(
          icon: Icons.nightlight_round,
          selected: isDarkTheme,
          onTap: () => setState(() => isDarkTheme = true),
        ),
      ],
    );
  }
}
