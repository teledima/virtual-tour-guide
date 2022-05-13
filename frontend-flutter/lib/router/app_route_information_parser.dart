// Flutter
import 'package:flutter/material.dart';
import 'package:frontend_flutter/data/tour_repository.dart';
// Application
import 'package:frontend_flutter/router/app_configuration.dart';

class AppRouteInformationParser extends RouteInformationParser<AppConfiguration> {
  @override
  Future<AppConfiguration> parseRouteInformation(RouteInformation routeInformation) async{
    final tourRepository = TourRepository();
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return AppConfiguration.home();
    }
    if (uri.pathSegments.length == 2) {
      final String first = uri.pathSegments[0];
      final String second = uri.pathSegments[1];

      if (first == 'tour' && second.isNotEmpty) {
        return AppConfiguration.pano(await tourRepository.fetchTour(second));
      }
    }
    return AppConfiguration.home();
  }

  @override
  RouteInformation? restoreRouteInformation(AppConfiguration configuration) {
    if (configuration.isHomePage) {
      return const RouteInformation(location: '/');
    } else if (configuration.isPanoPage) {
      return RouteInformation(location: '/tour/${configuration.currentTour!.tourId}');
    } else {
      return const RouteInformation(location: '/');
    }
  }
}