import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/password_field.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                  child: Text('Регистрация', style: TextStyle(fontSize: 24),)
                ),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Почта',
                    hintText: 'example@example.com',
                    border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Логин',
                    border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 12,),
                const PasswordField(
                  labelText: 'Пароль',
                  useShowButton: true, 
                ),
                const SizedBox(height: 12,),
                const PasswordField(
                  labelText: 'Повторите пароль',
                  useShowButton: true, 
                ),
                const SizedBox(height: 16,),
                TextButton(
                  onPressed: () => print('login'), 
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
      ),
    );
  }
}