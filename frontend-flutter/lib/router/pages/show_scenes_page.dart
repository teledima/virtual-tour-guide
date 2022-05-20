// Flutter
import 'package:flutter/material.dart';
import 'package:frontend_flutter/models.dart';
// Application
import 'package:frontend_flutter/screens/show_scenes_screen.dart';

class ShowScenesPage extends Page {
  final TourDetail tour;
  final Function() onReloadScenes;
  final Function(SceneDetail) onOpenScene;

  ShowScenesPage({
    required this.tour,
    required this.onReloadScenes,
    required this.onOpenScene
  }): super(key: ValueKey({"tour": tour, "showScenes": true}));
  
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (_) => ShowScenesScreen(
        tour: tour, 
        onReloadScenes: onReloadScenes,
        onOpenScene: onOpenScene
      )
    );
  }
}