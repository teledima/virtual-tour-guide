import 'package:flutter/material.dart';
import 'package:frontend_flutter_router/unknown_screen.dart';

class UnknownPage extends Page {

  const UnknownPage(): super(key: const ValueKey("UnknownPage"));
  
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => const UnknownScreen()
    );
  }
  
}