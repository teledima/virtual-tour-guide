// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/router/app_configuration.dart';
import 'pages/home_page.dart';
import 'pages/pano_page.dart';

class AppRouterDelegate extends RouterDelegate<AppConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  AppRouterDelegate(): _navigatorKey = GlobalKey<NavigatorState>();

  TourDetail? _currentTour;
  TourDetail? get currentTour => _currentTour;
  set currentTour(TourDetail? value) {
    _currentTour = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        HomePage(onTourSelected: (tour) => currentTour = tour),
        if (currentTour != null) PanoPage(currentTour: currentTour!)
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        currentTour = null;
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    if (configuration.isHomePage) {
      currentTour = null;
    } else if (configuration.isPanoPage) {
      currentTour = configuration.currentTour;
    } else {
      currentTour = null;
    }
  }

  @override
  AppConfiguration? get currentConfiguration {
    if (currentTour == null) {
      return AppConfiguration.home();
    } else if (currentTour != null) {
      return AppConfiguration.pano(currentTour!);
    } else {
      return null;
    }
  }

}