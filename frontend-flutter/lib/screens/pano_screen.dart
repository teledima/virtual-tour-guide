// Flutter
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// Application
import 'package:frontend_flutter/data/tour_repository.dart';
import 'package:frontend_flutter/data/hotspot_repository.dart';
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/widgets/hotspot_item.dart';
import 'package:frontend_flutter/widgets/prompt.dart';
import 'package:panorama/panorama.dart';
import 'package:frontend_flutter/screens/add_hotspot_dialog.dart';

class PanoScreen extends StatefulWidget {
  final TourRepository tourRepository = TourRepository();
  final HotspotRepository hotspotRepository = HotspotRepository();

  final TourDetail currentTour;

  final Function() onShowScenes;
  PanoScreen({
    Key? key, 
    required this.currentTour,
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
    _currentTour.then((tour) {
      _currentScene = tour.defaultScene;
    });
  }

  onAddImage() async {
    showDialog(
      context: context, 
      builder: (_) => const AddHotspotDialog()
    );
    /*
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    */
  }

  onTapHotspot(TourDetail tour, HotspotDetail hotspot) {
    setState(() {
      _currentScene = tour.findSceneById(hotspot.sceneId)!;
    });
  }

  onMoveHotspot(HotspotDetail hotspot) {
    setState(() {
      takePosition = true;
      _updatedHotspot = hotspot;
    });
  }

  onDeleteHotspot(TourDetail tour, SceneDetail currentScene, HotspotDetail hotspot) async {
    final result = await widget.hotspotRepository.deleteHotspot(tour, currentScene, hotspot);
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
                TextButton(style: style, onPressed: widget.onShowScenes, child: const Text('Scenes'))
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
                      onTap: () => onTapHotspot(snapshot.data!, hotspot),
                      onMove: () => onMoveHotspot(hotspot),
                      onDelete: () => onDeleteHotspot(snapshot.data!, _currentScene, hotspot),
                    )
                  )
              ],
              staticChildren: takePosition ? const [
                Positioned(bottom: 0, child: Prompt(message: 'Выберите новое место'))
              ] : [],
              onTap: (longtitude, latitude, _) async{
                if (takePosition) {
                  final result = await widget.hotspotRepository.moveHotspot(
                    snapshot.data!, 
                    _currentScene, 
                    _updatedHotspot!, 
                    latitude, 
                    longtitude
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
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: onAddImage,
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
              mini: true,
            ),
          );
        } else {
          return const Scaffold(body: Center(child: Text('Loading...'),));
        }
      }
    );
  } 
}