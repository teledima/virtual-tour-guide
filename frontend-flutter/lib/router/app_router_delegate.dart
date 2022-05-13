// Flutter
import 'package:flutter/material.dart';
import 'package:frontend_flutter/router/app_configuration.dart';
// Application
import 'pages/home_page.dart';

class AppRouterDelegate extends RouterDelegate<AppConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  AppRouterDelegate(): _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        HomePage()
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {

  }

}