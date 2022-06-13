// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/router/login_router/login_configuration.dart';

class LoginRouteInformationParser extends RouteInformationParser<LoginConfiguration> {
  @override
  Future<LoginConfiguration> parseRouteInformation(RouteInformation routeInformation) async{
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0];

      if (first == 'login') return LoginConfiguration.login();
      if (first == 'create') return LoginConfiguration.createAccount();
      if (first == 'restore') return LoginConfiguration.forgot(); 
    }

    return LoginConfiguration.login();
  }

  @override
  RouteInformation? restoreRouteInformation(LoginConfiguration configuration) {
    if (configuration.isLoginPage) {
      return const RouteInformation(location: '/login');
    } else if (configuration.isCreateAccountPage) {
      return const RouteInformation(location: '/create');
    } else if (configuration.isForgot) {
      return const RouteInformation(location: '/restore');
    }

    return null;
  }
}
