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

  AppConfiguration.newScene(TourDetail value)
    : currentTour = value,
      currentScene = SceneDetail.empty(),
      showScenes = false;

  bool get isHomePage => currentTour == null;
  bool get isPanoPage => currentTour != null && currentScene != SceneDetail.empty() && showScenes == false;
  bool get isNewScene => currentTour != null && currentScene == SceneDetail.empty() && showScenes == false;
  bool get isShowScenes => currentTour != null && showScenes == true;
}
