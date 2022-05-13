import 'package:flutter/material.dart';

import 'package:frontend_flutter_router/home_screen.dart';
import 'package:frontend_flutter_router/models.dart';

class HomePage extends Page {
  final List<Item> items;

  const HomePage({required this.items}): super(key: const ValueKey("HomePage"));
  
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => HomeScreen(items: items)
    );
  }
}