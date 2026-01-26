import 'package:evently/core/routes/go_route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Evently());
}

class Evently extends StatelessWidget {
  const Evently({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: AppRoutes.router);
  }
}
