// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/data/hotspot_repository.dart';
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/widgets/color_form_field.dart';
import 'package:frontend_flutter/widgets/scene_form_field.dart';

class AddHotspotDialog extends StatefulWidget {
  final String tourId;
  final String sceneId;
  final List<SceneDetail> scenes;
  final double longtitude, latitude;

  const AddHotspotDialog(
    this.tourId,
    this.sceneId,
    this.scenes,
    this.longtitude, 
    this.latitude, {
      Key? key
    }): super(key: key);

  @override
  AddHotspotDialogState createState() => AddHotspotDialogState();
}

class AddHotspotDialogState extends State<AddHotspotDialog> {
  final HotspotRepository hotspotRepository = HotspotRepository();
  final Map<String, String> items = {'navigation':'Навигационный указатель', 'info':'Информационный указатель'};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedType;
  String? _description;
  int? _selectedScene;
  Color _selectedColor = Colors.blue;

  List<DropdownMenuItem<String>> _getItems() {
    return items.keys.map<DropdownMenuItem<String>>(
      (key) => DropdownMenuItem(value: key, child: Text(items[key]!))
    ).toList();
  }

  Widget _buildHotspot() {
    if (_selectedType == 'navigation') {
      return Flexible(
        flex: 1,
        child:  SceneFormField(
          scenes: widget.scenes,
          validator: (item) {
            if (item == null) {
              return 'Выберите сцену';
            } else {
              return null;
            }
          },
          onSaved: (value) => setState(() => _selectedScene = value),
        )
      );
    } else if (_selectedType == 'info') {
      return Flexible(
        flex: 1,
        child: TextFormField(
          onSaved: (value) => setState(() => _description = value),
          decoration: const InputDecoration(
            hintText: 'Описание',
            isDense: true,
            border: OutlineInputBorder()
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Введите описание';
            } else {
              return null;
            }
          },
        )
      );
    } else {
      return const SizedBox();
    }
  }

  void onSubmitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      late final HotspotDetail hotspot;
      if (_selectedType == 'info') {
        hotspot = HotspotInfoDetail(
          latitude: widget.latitude,
          longtitude: widget.longtitude,
          description: _description!,
          colorCode: _selectedColor.value
        );
      } else if (_selectedType == 'navigation') {
        hotspot = HotspotNavigationDetail(
          latitude: widget.latitude, 
          longtitude: widget.longtitude, 
          sceneId: widget.scenes[_selectedScene!].sceneId,
          colorCode: _selectedColor.value
        );
      }
      final result = await hotspotRepository.createHotspot(widget.tourId, widget.sceneId, hotspot);
      if (result.modifiedCount == 1) {
        Navigator.of(context).pop(hotspot);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add hotspot'),
      scrollable: true,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: DropdownButtonFormField<String>(
                items: _getItems(), 
                onChanged: (item) => setState(() {
                  _selectedType = item ?? items.keys.first;
                }),
                hint: const Text('Тип указателя'),
                value: _selectedType,
                focusColor: Colors.white,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder()
                ),
                isExpanded: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Выберите тип указателя';
                  } else {
                    return null;
                  }
                },
              )
            ),
            if (_selectedType != null && items.keys.contains(_selectedType))
              ...[
                const SizedBox(height: 8,),
                _buildHotspot(),
                ColorFormField(
                  type: _selectedType!, 
                  onSaved: (color) => setState(() => _selectedColor = color!),
                  initialColor: _selectedColor,
                )
              ],
            const SizedBox(height: 12),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Широта: ${widget.longtitude.toInt()}'), 
                  Text('Долгота: ${widget.latitude.toInt()}'),
                ]
              )
            )
          ]
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey
          ),
          onPressed: () => Navigator.of(context).pop(), 
          child: const Text('Отмена')
        ),
        const SizedBox(width: 8,),
        ElevatedButton(onPressed: onSubmitForm, child: const Text('Добавить'))       
      ],
    );
  }
}
