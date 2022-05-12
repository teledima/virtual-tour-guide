import 'package:flutter/material.dart';

enum PopupAction { delete, edit }

class HotSpotButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final VoidCallback? onDelete;

  const HotSpotButton({Key? key, this.title = "", this.onPressed, this.onDelete}) : super(key: key);

  @override
  _HotSpotButtonState createState() => _HotSpotButtonState();
}

class _HotSpotButtonState extends State<HotSpotButton> {
  Offset _tapPosition = Offset.zero;
  
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onLongPressStart: (details) => setState(() {
        _tapPosition = details.globalPosition;
      }),
      onLongPress: () => showMenu(
        context: context, 
        position: RelativeRect.fromRect(_tapPosition & const Size(4, 4), Offset.zero & screenSize ), 
        items: <PopupMenuEntry>[
          PopupMenuItem(value: 1, child: const Text('Delete'), onTap: widget.onDelete)
        ]
      ),
      child: Column(
        children: [
          Text(widget.title),
          IconButton(
            onPressed: widget.onPressed,
            icon: const Icon(Icons.arrow_circle_up_sharp)
          )
        ],
      )
    );
  }
}