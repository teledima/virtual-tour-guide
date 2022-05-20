import 'package:frontend_flutter/models.dart';

class AppConfiguration {
  TourDetail? currentTour;
  SceneDetail? currentScene;
  bool showScenes;

  AppConfiguration.home()
    : currentTour = null,
      currentScene = null,
      showScenes = false;
  
  AppConfiguration.pano(TourDetail value, SceneDetail? scene)
    : currentTour = value,
      currentScene = scene,
      showScenes = false;
  
  AppConfiguration.panoScenes(TourDetail value)
    : currentTour = value,
      showScenes = true;

  bool get isHomePage => currentTour == null;
  bool get isPanoPage => currentTour != null && showScenes == false;
  bool get isShowScenes => currentTour != null && showScenes == true;
}