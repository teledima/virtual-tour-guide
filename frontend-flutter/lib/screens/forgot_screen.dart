import 'package:flutter/material.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({Key? key}): super(key: key);

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
                  child: Text('Сброс пароля', style: TextStyle(fontSize: 24),)
                ),
                const SizedBox(height: 24),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Почта',
                    hintText: 'example@example.com',
                    border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 16,),
                TextButton(
                  onPressed: () => print('restore'), 
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