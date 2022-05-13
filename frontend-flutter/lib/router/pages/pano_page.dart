// Flutter
import 'package:flutter/material.dart';

// Application
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/screens/pano_screen.dart';

class PanoPage extends Page {
  final TourDetail currentTour;

  PanoPage({required this.currentTour}): super(key: ValueKey(currentTour));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => PanoScreen(currentTour: currentTour)
    );
  }
}