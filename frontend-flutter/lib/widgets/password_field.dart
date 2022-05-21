import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String? labelText;
  final TextEditingController? controller;
  final bool? useShowButton;

  const PasswordField({
    Key? key, 
    this.labelText,
    this.controller,
    this.useShowButton
  }): super(key: key);

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  late bool _showPass;

  @override
  void initState() {
    super.initState();
    _showPass = widget.useShowButton ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
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
    );
  }
}