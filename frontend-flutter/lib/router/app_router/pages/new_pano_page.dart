// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/screens/new_pano_screen.dart';

class NewPanoPage extends Page {
  final TourDetail currentTour;

  const NewPanoPage({
    required this.currentTour
  }): super(key: const ValueKey("new_scene"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const NewPanoScreen()
    );
  }
}
