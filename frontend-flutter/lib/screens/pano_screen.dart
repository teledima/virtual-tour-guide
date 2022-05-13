// Flutter
import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';
// Application
import 'package:frontend_flutter/data/tour_repository.dart';
import 'package:frontend_flutter/models.dart';
import 'package:frontend_flutter/widgets/hotspot_item.dart';

class PanoScreen extends StatefulWidget {
  final TourRepository tourRepository = TourRepository();
  final TourDetail currentTour;
  PanoScreen({Key? key, required this.currentTour}): super(key: key);

  @override
  PanoScreenState createState() => PanoScreenState();
}

class PanoScreenState extends State<PanoScreen> {
  late Future<TourDetail> _currentTour;
  late SceneDetail _currentScene;
  
  @override
  void initState() {
    super.initState();
    _currentTour = widget.tourRepository.fetchTour(widget.currentTour.tourId);
    _currentTour.then((tour) {
      _currentScene = tour.defaultScene;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _currentTour,
        builder: (context, AsyncSnapshot<TourDetail> snapshot) {
          if (snapshot.hasData) {
            return Panorama(
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
                      onTap: () => print('tap'),
                      onDelete: () => print('delet'),
                    )
                  )
              ],
            );
          } else {
            return const Center(child: Text('Loading...'),);
          }
        }
      ),
    );
  } 
}