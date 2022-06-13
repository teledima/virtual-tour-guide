// Dart
import 'dart:async';
// Flutter
import 'package:flutter/material.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({Key? key}): super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  sendResetRequest(BuildContext context) {
    Timer timer = Timer(const Duration(seconds: 5), () => Navigator.of(context, rootNavigator: true).pop()); 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SimpleDialog(
          title: Text('Сброс пароля'),
          children: [
            Center(child: Text('Пароль сброшен'),)
          ],
        );
      }
    ).then((value) => timer.cancel());
  }

  onSubmitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      sendResetRequest(context);
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
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Align(
                  alignment: Alignment.center, 
                  child: Text('Сброс пароля', style: TextStyle(fontSize: 24),)
                ),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Почта',
                    hintText: 'example@example.com',
                    border: OutlineInputBorder()
                  ),
                  validator: (value) => value != null && value.isNotEmpty ? null : 'Введите почту',
                ),
                const SizedBox(height: 16,),
                TextButton(
                  onPressed: () => onSubmitForm(context), 
                  child: const Text('Сбросить пароль'),
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
      ),
    );
  }
}
