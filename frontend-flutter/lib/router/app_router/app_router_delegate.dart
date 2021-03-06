// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/data/tour_repository.dart';
import 'package:frontend_flutter/router/app_router/app_configuration.dart';
import 'package:frontend_flutter/router/app_router/pages/new_pano_page.dart';
import 'package:frontend_flutter/router/app_router/pages/show_scenes_page.dart';
import 'pages/home_page.dart';
import 'pages/pano_page.dart';

class AppRouterDelegate extends RouterDelegate<AppConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final TourRepository _tourRepository = TourRepository();

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  AppRouterDelegate(): _navigatorKey = GlobalKey<NavigatorState>();

  TourDetail? _currentTour;
  TourDetail? get currentTour => _currentTour;
  set currentTour(TourDetail? value) {
    _currentTour = value;
    notifyListeners();
  }

  bool _showScenes = false;
  bool get showScenes => _showScenes;
  set showScenes(bool value) {
    _showScenes = value;
    notifyListeners();
  }

  SceneDetail? _currentScene;
  SceneDetail? get currentScene => _currentScene;
  set currentScene(SceneDetail? value) {
    _currentScene = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        HomePage(
          onTourSelected: (tour) => currentTour = tour
        ),
        if (currentTour != null && currentScene != SceneDetail.empty()) PanoPage(
          currentTour: currentTour!,
          currentScene: currentScene,
          onShowScenes: () => showScenes = true
        ),
        if (currentTour != null && currentScene == SceneDetail.empty()) NewPanoPage(
          currentTour: currentTour!
        ),
        if (showScenes == true && currentTour != null) 
          ShowScenesPage(
            tour: currentTour!, 
            onReloadScenes: () async => currentTour = await _tourRepository.fetchTour(currentTour!.tourId),
            onOpenScene: (SceneDetail scene) { 
              currentScene = scene;
              showScenes = false;
            },
            onOpenNewScenePano: () {
              currentScene = SceneDetail.empty();
              showScenes = false;
            },
            onSetDefaultScene: (String sceneId) => currentTour!.defaultDetail = DefaultDetail(sceneId)
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (showScenes) { 
          showScenes = false;
        } else if (currentTour != null) {
          if (currentScene != null) {
            showScenes = true;
            currentScene = null;
          } else {
            currentTour = null;
            currentScene = null;
          }
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    if (configuration.isHomePage) {
      currentTour = null;
      showScenes = false;
    } else if (configuration.isPanoPage || configuration.isNewScene) {
      currentTour = configuration.currentTour;
      showScenes = false;
    } else if (configuration.isShowScenes) {
      currentTour = configuration.currentTour;
      showScenes = configuration.showScenes;
    } else {
      currentTour = null;
      showScenes = false;
    }
  }

  @override
  AppConfiguration? get currentConfiguration {
    if (currentTour == null) {
      return AppConfiguration.home();
    } else {
      if (!showScenes && currentScene != SceneDetail.empty()) {
        return AppConfiguration.pano(currentTour!, currentScene);
      } else if (!showScenes && currentScene == SceneDetail.empty()) {
        return AppConfiguration.newScene(currentTour!);
      } else {
        return AppConfiguration.panoScenes(currentTour!);
      }
    }
  }
}
