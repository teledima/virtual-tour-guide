// Flutter
import 'package:flutter/material.dart';
// Application
import 'package:frontend_flutter/data/tour_repository.dart';
import 'package:frontend_flutter/data/hotspot_repository.dart';
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/widgets/hotspot_item.dart';
import 'package:frontend_flutter/widgets/prompt.dart';
import 'package:frontend_flutter/screens/add_hotspot_dialog.dart';
import 'package:panorama/panorama.dart';

class PanoScreen extends StatefulWidget {
  final TourRepository tourRepository = TourRepository();
  final HotspotRepository hotspotRepository = HotspotRepository();

  final TourDetail currentTour;
  final SceneDetail? currentScene;

  final Function() onShowScenes;
  PanoScreen({
    Key? key, 
    required this.currentTour,
    this.currentScene,
    required this.onShowScenes
  }): super(key: key);

  @override
  PanoScreenState createState() => PanoScreenState();
}

class PanoScreenState extends State<PanoScreen> {
  late Future<TourDetail> _currentTour;
  late SceneDetail _currentScene;
  late HotspotDetail? _updatedHotspot;

  bool? _takePosition;
  bool get takePosition {
    if (_takePosition == null) {
      return false;
    }
    else {
      return _takePosition!;
    }
  }
  set takePosition(bool value) {
    _takePosition = value;
  }
  
  @override
  void initState() {
    super.initState();
    _currentTour = widget.tourRepository.fetchTour(widget.currentTour.tourId);
    if (widget.currentScene != null) {
      _currentScene = widget.currentScene!;
    } else {
      _currentTour.then((tour) {
        // TODO: check for vulnerability
        _currentScene = tour.defaultScene!;
      });
    }
  }

  onAddHotspot() async {
    setState(() {
      takePosition = true;
      _updatedHotspot = null;
    });
  }

  onTapHotspot(TourDetail tour, HotspotDetail hotspot) {
    setState(() {
      _currentScene = tour.findSceneById((hotspot as HotspotNavigationDetail).sceneId)!;
    });
  }

  onMoveHotspot(HotspotDetail hotspot) {
    setState(() {
      takePosition = true;
      _updatedHotspot = hotspot;
    });
  }

  onDeleteHotspot(TourDetail tour, SceneDetail currentScene, HotspotDetail hotspot) async {
    final result = await widget.hotspotRepository.deleteHotspot(tour.tourId, currentScene.sceneId, hotspot);
    if (result.modifiedCount > 0) {
      setState(() {
        _currentScene.deleteHotspot(hotspot);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return FutureBuilder(
      future: _currentTour,
      builder: (context, AsyncSnapshot<TourDetail> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data!.title),
              actions: [
                TextButton(style: style, onPressed: widget.onShowScenes, child: const Text('??????????')),
                // TODO
                TextButton(style: style, onPressed: () => print('exit'), child: const Text('??????????')),
              ],
            ),
            body: Panorama(
              child: Image.network('http://192.168.1.44:8080/images/${_currentScene.panorama}'),
              hotspots: [
                for (HotspotDetail hotspot in _currentScene.hotspots) 
                  Hotspot(
                    width: 100,
                    height: 100,
                    latitude: hotspot.latitude,
                    longitude: hotspot.longtitude,
                    widget: HotspotItem(
                      hotspotDetail: hotspot,
                      onTap: hotspot is HotspotNavigationDetail ? () => onTapHotspot(snapshot.data!, hotspot) : null,
                      onMove: () => onMoveHotspot(hotspot),
                      onDelete: () => onDeleteHotspot(snapshot.data!, _currentScene, hotspot),
                    )
                  )
              ],
              staticChildren: takePosition ? const [
                Positioned(bottom: 0, child: Prompt(message: '???????????????? ?????????? ??????????'))
              ] : [],
              onTap: (longtitude, latitude, _) async{
                if (takePosition && _updatedHotspot != null) {
                  final result = await widget.hotspotRepository.moveHotspot(
                    snapshot.data!.tourId, _currentScene.sceneId, 
                    _updatedHotspot!, latitude, longtitude
                  );

                  if (result.modifiedCount > 0) {
                    setState(() {
                      _currentScene.updateHotspotPosition(
                        _updatedHotspot!, 
                        latitude, 
                        longtitude
                      );

                      takePosition = false;
                      _updatedHotspot = null;
                    });                    
                  }
                } else if (takePosition && _updatedHotspot == null) {
                  setState(() {
                    takePosition = false;
                    _updatedHotspot = null;
                  });
                  final HotspotDetail? hotspot = await showDialog<HotspotDetail>(
                    context: context, 
                    builder: (_) => AddHotspotDialog(
                      widget.currentTour.tourId, 
                      _currentScene.sceneId,
                      widget.currentTour.scenes!, 
                      longtitude, latitude
                    )
                  );

                  if (hotspot != null) {
                    setState(() =>_currentScene.hotspots.add(hotspot));
                  }
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: onAddHotspot,
              child: const Icon(Icons.add, size: 32,),
            ),
          );
        } else {
          return const Scaffold(body: Center(child: Text('Loading...'),));
        }
      }
    );
  } 
}
