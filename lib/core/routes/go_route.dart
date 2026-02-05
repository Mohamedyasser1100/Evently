import 'package:evently/core/model/event_dm.dart';
import 'package:evently/core/routes/app_routes.dart';
import 'package:evently/features/auth/presentation/views/forgot_password_screen.dart';
import 'package:evently/features/auth/presentation/views/login_screen.dart';
import 'package:evently/features/auth/presentation/views/signup_screen.dart';
import 'package:evently/features/home/presentation/views/add_event_screen.dart';
import 'package:evently/features/home/presentation/views/edit_event.dart';
import 'package:evently/features/home/presentation/views/home_screen.dart';
import 'package:evently/features/home/presentation/views/widgets/event_details.dart';
import 'package:evently/features/navigation_bar/navigation_screen.dart';
import 'package:evently/features/onboarding/presentation/views/on_boarding_screen.dart';
import 'package:evently/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutes {
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: AppRoute.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
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
      GoRoute(
        path: AppRoute.navigationScreen,
        builder: (context, state) => const NavigationScreen(),
      ),
      GoRoute(
        path: AppRoute.addEventScreen,
        builder: (context, state) => const AddEventScreen(),
      ),
      GoRoute(
        path: AppRoute.editEventScreen,
        builder: (context, state) {
          EventDM event = state.extra as EventDM;
          return EditEventScreen(event: event);
        },
      ),
      GoRoute(
        path: AppRoute.eventDetails,
        builder: (context, state) {
          EventDM event = state.extra as EventDM;
          return EventDetails(event: event);
        },
      ),
      GoRoute(
        path: AppRoute.onBoardingScreen,
        builder: (context, state) => const OnBoardingScreen(),
      ),
    ],
  );
}
