import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/features/auth/presentation/views/forgot_password_screen.dart';
import 'package:evently/features/auth/presentation/views/login_screen.dart';
import 'package:evently/features/auth/presentation/views/signup_screen.dart';
import 'package:evently/features/home/home_screen.dart';
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
      GoRoute(
        path: AppRoute.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoute.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
