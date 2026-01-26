import 'package:evently/features/auth/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Evently());
}

class Evently extends StatelessWidget {
  const Evently({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: LoginScreen()));
  }
}
