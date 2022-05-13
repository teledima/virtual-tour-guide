import 'package:flutter/material.dart';
import 'package:frontend_flutter_router/bootstrap_screen.dart';

class BootstrapPage extends Page {

  const BootstrapPage(): super(key: const ValueKey("BootstrapPage"));
  
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => const BootstrapScreen()
    );
  }
  
}