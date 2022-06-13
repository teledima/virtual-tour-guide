// Flutter
import 'package:flutter/material.dart';
// Appilcation
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorSelectDialog extends StatefulWidget {
  final Color initialColor;

  const ColorSelectDialog({
    Key? key,
    required this.initialColor
  }): super(key: key);

  @override
  _ColorSelectDialogState createState() => _ColorSelectDialogState();
}

class _ColorSelectDialogState extends State<ColorSelectDialog> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Цвет'),
      alignment: Alignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) => setState(() => _selectedColor = color),
              colorPickerWidth: 300,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true,
              displayThumbColor: true,
              paletteType: PaletteType.hsvWithHue,
              labelTypes: const [],
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
              portraitOnly: true,
            ),
        ]
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey
          ),
          onPressed: () => Navigator.of(context).pop(widget.initialColor), 
          child: const Text('Отмена')
        ),
        const SizedBox(width: 8,),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_selectedColor), 
          child: const Text('Выбрать')
        )    
      ],
    );
  }
}
