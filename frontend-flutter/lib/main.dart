// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/router/app_router/app_route_information_parser.dart';
import 'package:frontend_flutter/router/app_router/app_router_delegate.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final _delegator = AppRouterDelegate();
  final _parser = AppRouteInformationParser();

  App({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _parser, 
      routerDelegate: _delegator
    );
  }
}
