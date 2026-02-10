import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/constatnt/app_styles.dart';
import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/features/auth/data/model/user_model.dart';
import 'package:evently/features/profile/presentation/views/widgets/setting_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ),
            SizedBox(height: 16),
            Text(
              UserModel.currentUser!.name,
              style: AppTextStyles.black20SemiBold,
            ),
            Text(
              UserModel.currentUser!.email,
              style: AppTextStyles.blue14Regulargray,
            ),
            SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: const Text(
                  'Dark mode',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.blue,
                  inactiveTrackColor: AppColors.offWhite,
                  inactiveThumbColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            SettingTile(
              onTap: () {},
              title: 'Language',
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            SizedBox(height: 16),
            SettingTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                GoRouter.of(context).pushReplacement(AppRoute.loginScreen);
              },
              title: 'Logout',
              trailing: Icon(Icons.logout, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
