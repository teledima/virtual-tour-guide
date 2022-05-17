// Dart
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
// Flutter
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// Application
import 'package:frontend_flutter/data/image_repository.dart';

class AddSceneDialog extends StatefulWidget {
  final ImageRepository imageRepository = ImageRepository();
  final String tourId;

  AddSceneDialog({
    Key? key,
    required this.tourId
  }): super(key: key);

  @override
  AddSceneDialogState createState() => AddSceneDialogState();
}

class AddSceneDialogState extends State<AddSceneDialog> {
  final _formKey = GlobalKey<FormState>();
  final _imageFieldKey = GlobalKey<FormFieldState<ImageField?>>();
  final sceneNameController = TextEditingController();

  onSelectImage(FormFieldState<ImageField?> state) async{
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      state.didChange(ImageField(image.readAsBytes(), image.mimeType ?? 'image/jpeg'));

      if (sceneNameController.text.isEmpty) {
        setState(() {
          sceneNameController.text = image.name.split(".").first;
        });
      }
    }
  }

  onSubmitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final res = await widget.imageRepository.sendImage(
          widget.tourId,
          await _imageFieldKey.currentState!.value!.bytes, 
          sceneNameController.text, 
          MediaType.parse(_imageFieldKey.currentState!.value!.mimeType)
        );
        if (res.modifiedCount > 0) {
          Navigator.of(context).pop(true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('tour not found')
            )
          );
        }
        
      } on DioError catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${e.message}\n${e.response.toString()}')
          )
        );
      }
    }
  }

  onCancelForm() {
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить сцену'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormField<ImageField?>(
              key: _imageFieldKey,
              builder: (formFieldState) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(onPressed: () => onSelectImage(formFieldState), child: const Text('Выберите изображение')),
                  const SizedBox(height: 8,),
                  
                  if (formFieldState.value != null)
                    FutureBuilder(
                      future: formFieldState.value!.bytes,
                      builder: (context, AsyncSnapshot<Uint8List> snapshot) {
                        if (snapshot.hasData) {
                          return Image.memory(snapshot.data!, width: 400, height: 225, fit: BoxFit.contain,);
                        } else {
                          return const Text('Loading...');
                        }
                      }
                    )
                  else 
                    Image.asset('assets/image_not_found.jpeg', fit: BoxFit.contain),
                  if (formFieldState.hasError) 
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 10),
                      child: Text(
                        formFieldState.errorText!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 13,
                          color: Colors.red[700],
                          height: 0.5),
                      )
                    ),
                  const SizedBox(height: 16,)
                ]
              ),
              
              validator: (value) {
                if (value == null) {
                  return 'Выберите изображение';
                }
                return null;
              },
            ),
            TextFormField(
              controller: sceneNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введите название сцены';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Название сцены',
                isDense: true,
                border: OutlineInputBorder()
              ),
            )
            
          ],
        ))
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey
          ),
          onPressed: onCancelForm, 
          child: const Text('Отмена')
        ),
        const SizedBox(width: 8,),
        ElevatedButton(onPressed: onSubmitForm, child: const Text('Добавить'))       
      ],
    );
  }
}

class ImageField {
  Future<Uint8List> bytes;
  String mimeType;

  ImageField(this.bytes, this.mimeType);
}