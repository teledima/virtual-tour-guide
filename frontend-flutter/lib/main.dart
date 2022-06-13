// Flutter
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// Application
import 'package:frontend_flutter/router/login_router/login_route_information_parser.dart';
import 'package:frontend_flutter/router/login_router/login_router_delegate.dart';

Future main() async{
  await dotenv.load(fileName: '.env');
  runApp(App());
}

class App extends StatelessWidget {
  final _delegatorLogin = LoginRouterDelegate();
  final _parserLogin = LoginRouteInformationParser();

  App({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _parserLogin, 
      routerDelegate: _delegatorLogin
    );
  }
}
