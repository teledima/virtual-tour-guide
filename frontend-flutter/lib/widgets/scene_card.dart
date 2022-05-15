// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';

class SceneCard extends StatelessWidget {
  final SceneDetail scene;

  Image get thumbnail {
    if (scene.thumbnail == null) {
      return Image.asset('assets/image_not_found.jpeg', fit: BoxFit.contain);
    } else {
      return Image.network('http://192.168.1.44:8080/images/${scene.thumbnail}');
    }
  }

  const SceneCard({Key? key, required this.scene}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text(scene.title ?? 'No title', style: const TextStyle(fontWeight: FontWeight.bold))),
            const SizedBox(height: 8),
            thumbnail
          ]
        )
      ),
    );
  }
}