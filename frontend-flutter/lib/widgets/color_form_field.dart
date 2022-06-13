import 'package:flutter/material.dart';
import 'package:frontend_flutter/widgets/color_select_dialog.dart';

class ColorFormField extends StatelessWidget {
  final Color initialColor;
  final String type;
  final Function(Color?) onSaved;

  const ColorFormField({
    Key? key,
    required this.type,
    required this.onSaved,
    required this.initialColor
  }): super(key: key);

  Icon _getIcon(Color color) {
    if (type == 'navigation') {
      return Icon(Icons.arrow_circle_up_outlined, color: color);
    } else if (type == 'info') {
      return Icon(Icons.info_outline, color: color);
    } else {
      return Icon(Icons.circle_outlined, color: color);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<Color>(
      initialValue: initialColor,
      builder: (FormFieldState<Color> fieldState) => ListTile(
        leading: SizedBox(
          height: double.infinity,
          child: _getIcon(fieldState.value!)
        ),
        title: const Text('Цвет'), 
        subtitle: const Text('Выберите цвет'),
        onTap: () async { 
          final color = await showDialog(
            context: context, 
            builder: (_) => ColorSelectDialog(initialColor: fieldState.value ?? initialColor)
          );
          fieldState.didChange(color);
        }
      ),
      onSaved: onSaved,
    );
  }  
}