// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/data/tour_repository.dart';
import 'package:frontend_flutter/router/app_configuration.dart';
import 'package:frontend_flutter/router/pages/show_scenes_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        HomePage(
          onTourSelected: (tour) => currentTour = tour
        ),
        if (currentTour != null) PanoPage(
          currentTour: currentTour!, 
          onShowScenes: () => showScenes = true
        ),
        if (showScenes == true && currentTour != null) 
          ShowScenesPage(
            tour: currentTour!, 
            onReloadScenes: () async => currentTour = await _tourRepository.fetchTour(currentTour!.tourId)
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (showScenes) { 
          showScenes = false;
        } else if (currentTour != null) {
          currentTour = null;
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
    } else if (configuration.isPanoPage) {
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
    } else if (currentTour != null) {
      if (!showScenes) {
        return AppConfiguration.pano(currentTour!);
      } else {
        return AppConfiguration.panoScenes(currentTour!);
      }
    } else {
      return null;
    }
  }

}