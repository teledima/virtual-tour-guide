import 'package:flutter/material.dart';

class ShowScenesScreen extends StatefulWidget {
  const ShowScenesScreen({Key? key}): super(key: key);

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