// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/screens/forgot_screen.dart';

class ForgotPage extends Page {
  const ForgotPage(): super(key: const ValueKey('ForgotPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => ForgotScreen()
    );
  }
}
