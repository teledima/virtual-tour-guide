// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/screens/home_screen.dart';

class HomePage extends Page {
  const HomePage(): super(key: const ValueKey("HomePage"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => HomeScreen()
    );
  }
}