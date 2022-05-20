// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/data/tour_repository.dart';

class SceneCard extends StatelessWidget {
  final SceneDetail scene;
  final String tourId;
  final TourRepository tourRepository = TourRepository();

  final Function(SceneDetail) onOpenScene;
  final Function(String) onSetDefaultScene;

  Image get thumbnail {
    if (scene.thumbnail == null) {
      return Image.asset('assets/image_not_found.jpeg', fit: BoxFit.contain);
    } else {
      return Image.network('http://192.168.1.44:8080/images/${scene.thumbnail}');
    }
  }

  SceneCard({
    Key? key, 
    required this.scene,
    required this.tourId,
    required this.onOpenScene,
    required this.onSetDefaultScene
  }): super(key: key);

  onSetDefaultSceneTap() async {
    await tourRepository.updateDefaultScene(tourId, scene.sceneId);
    onSetDefaultScene(scene.sceneId);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector (
        onTap: () => onOpenScene(scene),
        child: Container(
          clipBehavior: Clip.none,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      scene.title ?? 'No title', 
                      style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,
                    )
                  ),
                  PopupMenuButton(itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: const Text('Начальная сцена'),
                      onTap: onSetDefaultSceneTap,
                    )
                  ])
                ]
              ),
              const SizedBox(height: 8),
              thumbnail,
            ]
          ),
        )
      ),
    );
  }
}