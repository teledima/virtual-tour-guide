// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/router/login_router/login_configuration.dart';
import 'package:frontend_flutter/router/login_router/pages/create_account_page.dart';
import 'package:frontend_flutter/router/login_router/pages/forgot_page.dart';
import 'package:frontend_flutter/router/login_router/pages/login_page.dart';
import 'package:frontend_flutter/router/login_router/pages/tour_page.dart';

class LoginRouterDelegate extends RouterDelegate<LoginConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  bool? _isLogin;
  bool? get isLogin => _isLogin;
  set isLogin(bool? value) {
    _isLogin = value;
    notifyListeners();
  }

  bool? _isCreateAccount;
  bool get isCreateAccount => _isCreateAccount ?? false;
  set isCreateAccount(bool value) {
    _isCreateAccount = value;
    notifyListeners();
  }

  bool? _isForgot;
  bool get isForgot => _isForgot ?? false;
  set isForgot(bool value) {
    _isForgot = value;
    notifyListeners();
  }

  LoginRouterDelegate(): _isLogin = true, _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (isLogin ?? false) LoginPage(
          onLogin: () {
            isLogin = null;
            isCreateAccount = false;
            isForgot = false;
          },
          onCreateAccount: () {
            isLogin = false;
            isCreateAccount = true;
            isForgot = false;
          },
          onForgot: () {
            isLogin = false;
            isCreateAccount = false;
            isForgot = true;
          }
        ),
        if (isCreateAccount) const CreateAccountPage(),
        if (isForgot) const ForgotPage(),
        if (isLogin == null) const TourPage()
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (isCreateAccount == true || isForgot == true) {
          isLogin = true;
          isCreateAccount = false;
          isForgot = false;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(LoginConfiguration configuration) async{
    if (configuration.isLoginPage) {
      isLogin = true;
      isCreateAccount = false;
      isForgot = false;
    } else if (configuration.isCreateAccountPage) {
      isLogin = false;
      isCreateAccount = true;
      isForgot = false;
    } else if (configuration.isForgotPage) {
      isLogin = false;
      isCreateAccount = false;
      isForgot = true;
    }
  }
  
  @override
  LoginConfiguration? get currentConfiguration {
    if (isLogin ?? false) {
      return LoginConfiguration.login();
    } else if (isCreateAccount) {
      return LoginConfiguration.createAccount();
    } else if (isForgot) {
      return LoginConfiguration.forgot();
    }
    return null;
  }
}