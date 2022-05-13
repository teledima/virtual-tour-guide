import 'package:flutter/material.dart';

import 'package:frontend_flutter_router/data/item_repository.dart';
import 'package:frontend_flutter_router/router/my_app_configuration.dart';

class MyAppRouteInformationParser extends RouteInformationParser<MyAppConfiguration> {
  final ItemRepository _itemRepository;

  const MyAppRouteInformationParser({
    required ItemRepository itemRepository
  }): _itemRepository = itemRepository, super();

  @override
  Future<MyAppConfiguration> parseRouteInformation(RouteInformation routeInformation) async{
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isEmpty) return MyAppConfiguration.bootstrap();

    if (uri.pathSegments.length == 2) {
      final String first = uri.pathSegments[0];
      final String second = uri.pathSegments[1];

      if (first == 'detail' && second.isNotEmpty) return MyAppConfiguration.detail(await _itemRepository.fetchItemDetail(second));
    }

    return MyAppConfiguration.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(MyAppConfiguration configuration) {
    if (configuration.isUnknown) {
      return const RouteInformation(location: '/unknown');
    } else if (configuration.isHome) {
      return const RouteInformation(location: '/');
    } else if (configuration.isDetail) {
      return RouteInformation(location: '/detail/${configuration.detail!.id}');
    } else {
      return null;
    }
  }
}
