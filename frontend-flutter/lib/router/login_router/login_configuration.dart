import 'package:flutter/cupertino.dart';

class LoginConfiguration {
  bool isLogin;
  bool isCreateAccount;
  bool isForgot;

  LoginConfiguration.login()
    : isLogin = true,
      isCreateAccount = false,
      isForgot = false;

  LoginConfiguration.createAccount() 
    : isLogin = false,
      isCreateAccount = true,
      isForgot = false;

  LoginConfiguration.forgot()
    : isLogin = false,
      isCreateAccount = false,
      isForgot = true;
  
  bool get isLoginPage => isLogin;
  bool get isCreateAccountPage => isCreateAccount;
  bool get isForgotPage => isForgot;
}