import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/password_form_field.dart';

class LoginScreen extends StatelessWidget {
  final Function() onLogin;
  final Function() onCreateAccount;
  final Function() onForgot;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({
    Key? key, 
    required this.onLogin,
    required this.onCreateAccount,
    required this.onForgot
  }): super(key: key);

  onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      onLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Align(
                  alignment: Alignment.center, 
                  child: Text('Вход', style: TextStyle(fontSize: 24),)
                ),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Логин',
                    border: OutlineInputBorder()
                  ),
                  validator: (value) => value != null && value.isNotEmpty ? null : 'Введите логин',
                ),
                const SizedBox(height: 12,),
                PasswordFormField(
                  labelText: 'Пароль',
                  useShowButton: true,
                  validator: (value) => value != null && value.isNotEmpty ? null : 'Введите пароль',
                ),
                Align(
                  alignment: Alignment.centerRight, 
                  child: TextButton(onPressed: onForgot, child: const Text('Забыли пароль?'))
                ),
                const SizedBox(height: 16,),
                TextButton(
                  onPressed: onSubmitForm, 
                  child: const Text('Войти'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    fixedSize: const Size.fromHeight(40)
                  ),
                ),
                const SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Нет аккаунта?'),
                    const SizedBox(width: 4,),
                    Text.rich(
                      TextSpan(
                        text: 'Зарегистрируйтесь', 
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = onCreateAccount
                      ),
                    )
                  ],
                )
              ],
            )
          )
        )
      ),
    );
  }
}