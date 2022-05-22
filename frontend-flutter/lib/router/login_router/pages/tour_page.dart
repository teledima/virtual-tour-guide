// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/screens/tour_screen.dart';

class TourPage extends Page {
  const TourPage(): super(key: const ValueKey("TourPage"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => TourScreen()
    );
  }
}