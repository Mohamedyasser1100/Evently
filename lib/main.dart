import 'package:evently/core/cubit/language_cubit.dart';
import 'package:evently/core/helper/cache_helper.dart';
import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/core/routes/go_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  runApp(const Evently());
}

class Evently extends StatelessWidget {
  const Evently({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRoutes.router,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('ar')],
            locale: locale,
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
