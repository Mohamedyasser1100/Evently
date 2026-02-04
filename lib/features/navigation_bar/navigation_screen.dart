import 'package:evently/core/constatnt/app_colors.dart';
import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/features/favorite/presentation/views/favorite_screen.dart';
import 'package:evently/features/home/presentation/views/home_screen.dart';
import 'package:evently/features/profile/presentation/views/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  var selectedIndex = 0;
  var tabs = [HomeScreen(), FavoriteScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        body: tabs[selectedIndex],
        floatingActionButton: buildFAB(),
        bottomNavigationBar: buildBottomNavigation(),
      ),
    );
  }

  buildFAB() => FloatingActionButton(
    onPressed: () {
      GoRouter.of(context).push(AppRoute.addEventScreen);
    },
    backgroundColor: AppColors.blue,
    shape: CircleBorder(),
    child: Icon(Icons.add, color: Colors.white),
  );

  Widget buildBottomNavigation() => Theme(
    data: ThemeData(canvasColor: Colors.white),
    child: BottomNavigationBar(
      selectedItemColor: AppColors.blue,
      unselectedItemColor: AppColors.grey2,
      currentIndex: selectedIndex,
      onTap: (newIndex) {
        selectedIndex = newIndex;
        setState(() {});
      },
      items: [
        buildBottomNavigationBarItem(Icons.home, "Home"),
        buildBottomNavigationBarItem(Icons.favorite_border, "Favorite"),
        buildBottomNavigationBarItem(Icons.person, "Profile"),
      ],
    ),
  );

  BottomNavigationBarItem buildBottomNavigationBarItem(
    IconData iconData,
    String label,
  ) => BottomNavigationBarItem(icon: Icon(iconData), label: label);
}
