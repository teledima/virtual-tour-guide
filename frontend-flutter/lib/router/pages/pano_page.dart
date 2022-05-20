// Flutter
import 'package:flutter/material.dart';

// Application
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/screens/pano_screen.dart';

class PanoPage extends Page {
  final TourDetail currentTour;
  final SceneDetail? currentScene;
  final Function() onShowScenes;

  PanoPage({
    required this.currentTour,
    this.currentScene,
    required this.onShowScenes
  }): super(key: ValueKey({ currentTour: currentTour, currentScene: currentScene }));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => PanoScreen(currentTour: currentTour, currentScene: currentScene, onShowScenes: onShowScenes,)
    );
  }
}