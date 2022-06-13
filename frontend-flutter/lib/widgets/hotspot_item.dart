// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/models.dart';

class HotspotItem extends StatefulWidget {
  final HotspotDetail hotspotDetail;
  final Function()? onTap;
  final Function() onMove;
  final Function() onDelete;

  const HotspotItem({
    Key? key, 
    required this.hotspotDetail,
    this.onTap,
    required this.onMove,
    required this.onDelete,
  }): super(key: key);

  @override
  HotspotItemState createState() => HotspotItemState();
}

class HotspotItemState extends State<HotspotItem> {
  bool _showDescription = false;
  Offset _tapPosition = Offset.zero;

  Widget _buildHotspot() {
    if (widget.hotspotDetail is HotspotInfoDetail) {
      return Column(
        children: [
          if (_showDescription) Text((widget.hotspotDetail as HotspotInfoDetail).description),
          IconButton(
            onPressed: () => setState(() => _showDescription = !_showDescription),
            icon: Icon(Icons.info_outline, color: widget.hotspotDetail.color)
          )
        ],
      );
    } else if (widget.hotspotDetail is HotspotNavigationDetail) {
      return Column(
        children: [
          IconButton(
            onPressed: widget.onTap,
            icon: Icon(Icons.arrow_circle_up_outlined, color: widget.hotspotDetail.color,)
          )
        ],
      ); 
    } else {
      return Column(
        children: [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.circle_outlined, color: widget.hotspotDetail.color,)
          )
        ],
      );
    }
  }

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
      child: _buildHotspot()
    );
  }
}