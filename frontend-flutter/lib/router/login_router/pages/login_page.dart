// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/screens/login_screen.dart';

class LoginPage extends Page {
  final Function() onCreateAccount;
  final Function() onForgot;

  const LoginPage({
    required this.onCreateAccount,
    required this.onForgot
  }): super(key: const ValueKey('LoginPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => LoginScreen(onCreateAccount: onCreateAccount, onForgot: onForgot,)
    );
  }
}