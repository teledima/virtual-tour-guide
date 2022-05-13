import 'package:flutter/material.dart';

class BootstrapScreen extends StatelessWidget {
  const BootstrapScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My App')),
      body: const Center(
        child: Text('Fetch list...'),
      )
    );
  }
}