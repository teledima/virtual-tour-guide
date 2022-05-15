// Flutter
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddSceneDialog extends StatefulWidget {
  const AddSceneDialog({Key? key}): super(key: key);

  @override
  AddSceneDialogState createState() => AddSceneDialogState();
}

class AddSceneDialogState extends State<AddSceneDialog> {
  /*
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  */

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить сцену'),
      content: Container(
        child: Row(
          children: [
            TextButton(onPressed: () => print('click'), child: const Text('Выберите изображение'))
          ],
        )
      ),
    );
  }
}