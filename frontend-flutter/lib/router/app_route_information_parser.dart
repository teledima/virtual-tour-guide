// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/router/app_configuration.dart';

class AppRouteInformationParser extends RouteInformationParser<AppConfiguration> {
  @override
  Future<AppConfiguration> parseRouteInformation(RouteInformation routeInformation) async{
    return AppConfiguration();
  }

  @override
  RouteInformation? restoreRouteInformation(AppConfiguration configuration) {
    return RouteInformation(location: '/');
  }

}