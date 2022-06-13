import 'package:flutter/material.dart';
import 'package:frontend_flutter/models.dart';

class AddTourDialog extends StatelessWidget {
  AddTourDialog({Key? key}): super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  void onSubmitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(TourDetail("", _controller.text, null, null));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Создать тур')),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Название',
                isDense: true,
                border: OutlineInputBorder()
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введите название';
                } else {
                  return null;
                }
              },
            )
          ],
        )
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
        ElevatedButton(onPressed: () => onSubmitForm(context), child: const Text('Добавить'))       
      ],
    );
  }
}