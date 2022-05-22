import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final String? labelText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool? useShowButton;

  const PasswordFormField({
    Key? key, 
    this.labelText,
    this.controller,
    this.validator,
    this.useShowButton
  }): super(key: key);

  @override
  PasswordFormFieldState createState() => PasswordFormFieldState();
}

class PasswordFormFieldState extends State<PasswordFormField> {
  late bool _showPass;

  @override
  void initState() {
    super.initState();
    _showPass = widget.useShowButton ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _showPass,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
        suffixIcon: widget.useShowButton ?? false ? 
          IconButton(
            splashRadius: 1,
            icon: Icon(_showPass == true ?  Icons.visibility : Icons.visibility_off), 
            onPressed: () => setState(() =>_showPass = !_showPass)
          ) : null
      ),
      controller: widget.controller,
      validator: widget.validator,
    );
  }
}