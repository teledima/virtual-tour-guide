// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/widgets/expandable_fab.dart';
import 'package:frontend_flutter/widgets/scene_card.dart';
import 'package:frontend_flutter/screens/add_scene_dialog.dart';

class ShowScenesScreen extends StatefulWidget {
  final TourDetail tour;
  final Function() onReloadScenes;
  final Function(SceneDetail) onOpenScene;
  final Function() onOpenNewScenePano;
  final Function(String) onSetDefaultScene;

  const ShowScenesScreen({
    Key? key,
    required this.tour,
    required this.onReloadScenes,
    required this.onOpenScene,
    required this.onOpenNewScenePano,
    required this.onSetDefaultScene
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
    final ButtonStyle style = TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    final List<Widget> children = [
      for (var scene in widget.tour.scenes!)
        SceneCard(
          tourId: widget.tour.tourId, 
          scene: scene, 
          onOpenScene: widget.onOpenScene,
          onSetDefaultScene: widget.onSetDefaultScene
        )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сцены'),
        actions: [
          // TODO
          TextButton(style: style, onPressed: () => print('exit'), child: const Text('Выход')),
        ],
      ),
      body: GridView.extent(maxCrossAxisExtent: 360, children: children,),
      floatingActionButton: ExpandableFab(
        distance: 100, 
        children: <Widget> [
          ActionButton(
            onPressed: widget.onOpenNewScenePano,
            icon: const Icon(Icons.add_a_photo),
            tooltip: 'Создать новую сцену',
          ),
          ActionButton(
            onPressed: onAddScene,
            icon: const Icon(Icons.upload),
            tooltip: 'Загрузить существующую сцену',
          ),
        ]
      )
    );
  }
}
