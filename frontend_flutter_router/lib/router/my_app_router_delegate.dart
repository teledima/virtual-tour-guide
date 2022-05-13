import 'package:flutter/material.dart';

import 'package:frontend_flutter_router/data/item_repository.dart';
import 'package:frontend_flutter_router/models.dart';
import 'package:frontend_flutter_router/router/my_app_configuration.dart';
import 'package:frontend_flutter_router/router/pages/bootstrap.dart';
import 'pages/home.dart';
import 'pages/detail.dart';
import 'pages/unknown.dart';

class MyAppRouterDelegate extends RouterDelegate<MyAppConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final ItemRepository _itemRepository;

  MyAppRouterDelegate({
    required ItemRepository itemRepository
  }): _navigatorKey = GlobalKey<NavigatorState>(), _itemRepository = itemRepository {
    _init();
  }

  List<Item>? _items;
  List<Item> get items {
    return _items ?? [];
  }
  set items(List<Item>? value) {
    _items = value;
    unknown = false;
    notifyListeners();
  }

  bool? _unknown;
  bool get unknown {
    if (_unknown != null && _unknown == true) {
      return true;
    } else {
      return false;
    }
  }
  set unknown(bool? value) {
    _unknown = value;
    notifyListeners();
  }

  bool _bootsraped = false;
  bool get bootstraped => _bootsraped;
  set bootstraped(bool value) {
    _bootsraped = value;
    notifyListeners();
  }

  _init() async {
    items =  await _itemRepository.fetchItems();
    bootstraped = true;
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (!bootstraped) 
          const BootstrapPage() 
        else 
          HomePage(items: items),
        if (unknown == true) const UnknownPage()
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (unknown) unknown = false;
        return true;
      },
    );
  }
  
  @override
  Future<void> setNewRoutePath(MyAppConfiguration configuration) async{
    if (configuration.isUnknown) {
      unknown = true;
    } else if (configuration.isHome) {
      unknown = false;
      bootstraped = true;
    } else {
      unknown = false;
      bootstraped = false;
      await _itemRepository.fetchItems();
      bootstraped = true;
    }
  }

  @override
  MyAppConfiguration? get currentConfiguration {
    if (unknown) {
      return MyAppConfiguration.unknown();
    } else if (bootstraped == true) {
      return MyAppConfiguration.home();
    } else if (bootstraped == false) {
      return MyAppConfiguration.bootstrap();
    } else {
      return null;
    }
  }
}