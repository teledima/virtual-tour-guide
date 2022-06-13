// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/screens/login_screen.dart';

class LoginPage extends Page {
  final Function() onLogin;
  final Function() onCreateAccount;
  final Function() onForgot;

  const LoginPage({
    required this.onLogin,
    required this.onCreateAccount,
    required this.onForgot
  }): super(key: const ValueKey('LoginPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => LoginScreen(onLogin: onLogin, onCreateAccount: onCreateAccount, onForgot: onForgot,)
    );
  }
}
