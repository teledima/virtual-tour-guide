// Dart
import 'dart:async';
// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/widgets/password_form_field.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({Key? key}): super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  sendAccountCreateRequest(BuildContext context) {
    Timer timer = Timer(const Duration(seconds: 5), () => Navigator.of(context, rootNavigator: true).popUntil((route) => false)); 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SimpleDialog(
          title: Text('Регистрация'),
          children: [
            Center(child: Text('Аккаунт создан'),)
          ],
        );
      }
    ).then((value) => timer.cancel());
  }

  onSubmitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      sendAccountCreateRequest(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Align(
                      alignment: Alignment.center, 
                      child: Text('Регистрация', style: TextStyle(fontSize: 24),)
                    ),
                    const SizedBox(height: 12,),
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
                    const SizedBox(height: 12,),
                    PasswordFormField(
                      labelText: 'Повторите пароль',
                      useShowButton: true, 
                      validator: (value) => value != null && value.isNotEmpty ? null : 'Повторите пароль',
                    ),
                    const SizedBox(height: 16,),
                    TextButton(
                      onPressed: () => onSubmitForm(context), 
                      child: const Text('Зарегистрироваться'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        fixedSize: const Size.fromHeight(40)
                      ),
                    )
                  ],
                )
              )
            )
          )
        ),
      ), 
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      }
    );
  }
}
