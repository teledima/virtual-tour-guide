// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/widgets/scene_card.dart';
import 'package:frontend_flutter/screens/add_scene_dialog.dart';

class ShowScenesScreen extends StatefulWidget {
  final TourDetail tour;
  final Function() onReloadScenes;
  const ShowScenesScreen({
    Key? key,
    required this.tour,
    required this.onReloadScenes
  }): super(key: key);

  @override
  ShowScenesScreenState createState() => ShowScenesScreenState();
}

class ShowScenesScreenState extends State<ShowScenesScreen> {
  onAddScene() async {
    final reload = await showDialog<bool>(
      context: context, 
      builder: (_) => AddSceneDialog(tourId: widget.tour.tourId)
    );
    
    if (reload ?? false) widget.onReloadScenes();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      for (var scene in widget.tour.scenes!)
        SceneCard(tourId: widget.tour.tourId, scene: scene)
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