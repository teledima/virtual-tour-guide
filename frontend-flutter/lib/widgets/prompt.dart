import 'package:flutter/material.dart';

class Prompt extends StatelessWidget {
  final String message;
  const Prompt({Key? key, required this.message }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(message), 
        padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
    );
  }
}
