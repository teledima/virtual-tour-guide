// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';

class ShowScenesScreen extends StatefulWidget {
  final TourDetail tour;
  const ShowScenesScreen({
    Key? key,
    required this.tour
  }): super(key: key);

  @override
  ShowScenesScreenState createState() => ShowScenesScreenState();
}

class ShowScenesScreenState extends State<ShowScenesScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scenes')),
      body: const Center(child: Text('Show scenes')),
    );
  }
}