import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/features/auth/login_screen.dart';
import 'package:evently/features/auth/signup_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutes {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: AppRoute.signupScreen,
        builder: (context, state) => const SignupScreen(),
      ),
    ],
  );
}
