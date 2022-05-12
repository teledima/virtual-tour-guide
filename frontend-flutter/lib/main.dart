import 'package:flutter/material.dart';

import './ToursListPage.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Virtual guide",
      home: ToursListPage()
    );
  }
}
