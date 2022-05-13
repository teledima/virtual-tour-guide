import 'package:flutter/material.dart';
import 'package:frontend_flutter_router/data/item_repository.dart';
import 'package:frontend_flutter_router/providers/list_items.dart';
import 'package:frontend_flutter_router/router/my_app_route_information_parser.dart';
import 'package:frontend_flutter_router/router/my_app_router_delegate.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final MyAppRouterDelegate _delegate = MyAppRouterDelegate(itemRepository: ItemRepository());
  final MyAppRouteInformationParser _parser = MyAppRouteInformationParser(itemRepository: ItemRepository());

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListItemsModel(_delegate.items), 
      child: MaterialApp.router(
          routeInformationParser: _parser, 
          routerDelegate: _delegate
      )
    );
  }
}