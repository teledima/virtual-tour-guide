// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/widgets/scene_card.dart';
import 'package:frontend_flutter/screens/add_scene_dialog.dart';

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
  onAddScene() {
    showDialog(
      context: context, 
      builder: (_) => AddSceneDialog()
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      for (var scene in widget.tour.scenes!)
        SceneCard(scene: scene)
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Scenes')),
      body: GridView.extent(maxCrossAxisExtent: 360, children: children,),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddScene,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        mini: true,
      ),
    );
  }
}