// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/router/app_router/app_route_information_parser.dart';
import 'package:frontend_flutter/router/app_router/app_router_delegate.dart';
import 'package:frontend_flutter/router/login_router/login_route_information_parser.dart';
import 'package:frontend_flutter/router/login_router/login_router_delegate.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final _delegator = AppRouterDelegate();
  final _parser = AppRouteInformationParser();

  final _delegator_login = LoginRouterDelegate();
  final _parser_login = LoginRouteInformationParser();

  App({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _parser_login, 
      routerDelegate: _delegator_login
    );
  }
}
