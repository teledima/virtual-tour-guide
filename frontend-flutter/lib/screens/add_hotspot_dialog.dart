import 'package:flutter/material.dart';

class AddHotspotDialog extends StatefulWidget {
  const AddHotspotDialog({Key? key}): super(key: key);

  @override
  AddHotspotDialogState createState() => AddHotspotDialogState();
}

class AddHotspotDialogState extends State<AddHotspotDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add hotspot'),
    );
  }
}