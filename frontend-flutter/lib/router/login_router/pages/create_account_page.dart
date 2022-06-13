// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/screens/create_account_screen.dart';

class CreateAccountPage extends Page {
  const CreateAccountPage(): super(key: const ValueKey('CreateAccountPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => CreateAccountScreen()
    );
  }
}
