// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';

class HotspotItem extends StatefulWidget {
  final HotspotDetail hotspotDetail;
  final Function() onTap;
  final Function() onMove;
  final Function() onDelete;

  const HotspotItem({
    Key? key, 
    required this.hotspotDetail,
    required this.onTap,
    required this.onMove,
    required this.onDelete
  }): super(key: key);

  @override
  HotspotItemState createState() => HotspotItemState();
}

class HotspotItemState extends State<HotspotItem> {
  Offset _tapPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onLongPressStart: (details) => setState(() => _tapPosition = details.globalPosition),
      onLongPress: () => showMenu(
        context: context, 
        position: RelativeRect.fromRect(_tapPosition & const Size(4, 4), Offset.zero & screenSize ), 
        items: <PopupMenuEntry>[
          PopupMenuItem(value: 1, child: const Text('Move'), onTap: widget.onMove),
          PopupMenuItem(value: 2, child: const Text('Delete'), onTap: widget.onDelete)
        ]
      ),
      child: Column(
        children: [
          const Text('test'),
          IconButton(
            onPressed: widget.onTap,
            icon: const Icon(Icons.arrow_circle_up_sharp)
          )
        ],
      )
    );
  }
}