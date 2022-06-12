import 'package:flutter/material.dart';
import 'package:frontend_flutter/data/hotspot_repository.dart';
import 'package:frontend_flutter/models.dart';
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

  List<DropdownMenuItem<String>> _getItems() {
    return items.keys.map<DropdownMenuItem<String>>(
      (key) => DropdownMenuItem(value: key, child: Text(items[key]!))
    ).toList();
  }

  Widget _buildHotspot() {
    if (_selectedType == 'navigation') {
      return 
        Flexible(
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
        hotspot = HotspotInfoDetail(widget.latitude, widget.longtitude, _description!);
      } else if (_selectedType == 'navigation') {
        hotspot = HotspotNavigationDetail(widget.latitude, widget.longtitude, widget.scenes[_selectedScene!].sceneId);
      }
      final result = await hotspotRepository.createHotspot(widget.tourId, widget.sceneId, hotspot);
      print(result);
      if (result.modifiedCount == 1) {
        Navigator.of(context).pop(hotspot);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add hotspot'),
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
                hint: const Text('Выберите тип указателя'),
                value: _selectedType,
                focusColor: Colors.white,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder()
                ),
              )
            ),
            if (_selectedType != null && items.keys.contains(_selectedType))
              ...[
                const SizedBox(height: 8,),
                _buildHotspot()
              ],
            const SizedBox(height: 12),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Широта: ${widget.longtitude.toInt()}'), 
                  Text('Долгота: ${widget.latitude.toInt()}'),
                  Text('Id: $_selectedScene')
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
