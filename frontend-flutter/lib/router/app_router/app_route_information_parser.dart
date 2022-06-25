import 'package:quiver/strings.dart' as quiver;
// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/data/tour_repository.dart';
import 'package:frontend_flutter/router/app_router/app_configuration.dart';

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
        final tour = await tourRepository.fetchTour(second);
        final state = routeInformation.state as Map?;

        return AppConfiguration.pano(tour, tour.findSceneById(state?['sceneId']));
      }
    } else if ([3, 4].contains(uri.pathSegments.length)) {
      final String first = uri.pathSegments[0];
      final String second = uri.pathSegments[1];
      final String third = uri.pathSegments[2];
      final String? four = uri.pathSegments.length == 4 ? uri.pathSegments[3] : null;

      if (first == 'tour' && second.isNotEmpty && third == 'scenes') {
        if (quiver.isBlank(four) == true || four != 'new') {
          return AppConfiguration.panoScenes(await tourRepository.fetchTour(second));
        } else {
          return AppConfiguration.newScene(await tourRepository.fetchTour(second));
        }
      }
    }
    return AppConfiguration.home();
  }

  @override
  RouteInformation? restoreRouteInformation(AppConfiguration configuration) {
    if (configuration.isHomePage) {
      return const RouteInformation(location: '/');
    } else if (configuration.isShowScenes) {
      return RouteInformation(location: '/tour/${configuration.currentTour!.tourId}/scenes');
    } else if (configuration.isPanoPage) {
      return RouteInformation(location: '/tour/${configuration.currentTour!.tourId}', state: {"sceneId": configuration.currentScene?.sceneId});
    } else if (configuration.isNewScene) {
      return RouteInformation(location: '/tour/${configuration.currentTour!.tourId}/scenes/new');
    } else {
      return const RouteInformation(location: '/');
    }
  }
}
