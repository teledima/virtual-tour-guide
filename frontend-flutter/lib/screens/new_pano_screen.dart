import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';

import 'package:panorama/panorama.dart';


class NewPanoScreen extends StatefulWidget {
  const NewPanoScreen({Key? key}): super(key: key);
  
  @override
  _NewPanoScreenState createState() => _NewPanoScreenState();
}

class _NewPanoScreenState extends State<NewPanoScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  late bool _alignCamera;
  late double _currentLongtitude;
  final Offset latlonDelta = const Offset(1, 1);
  final double alignLatitude = 0;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      GetIt.I.get<CameraDescription>(), 
      ResolutionPreset.medium
    );
    _initializeControllerFuture = _controller.initialize();
    _alignCamera = true;
    _currentLongtitude = 0;
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Panorama(
          sensorControl: SensorControl.Orientation,
          child: Image.asset('assets/black_image.jpg'),
          hotspots: [ 
            Hotspot(
              longitude: _currentLongtitude,
              latitude: alignLatitude,
              widget: Icon(Icons.circle_sharp, color: _alignCamera ? Colors.red : Colors.blue, size: 50,)
            )
          ],
          staticChildren: [
            Positioned(
              top: (constraints.maxHeight - 58) / 2,
              left: (constraints.maxWidth - 58) / 2,
              child: const Icon(Icons.circle_outlined, color: Colors.orange, size: 75,)
            ),
          ],
          onViewChanged: (longtitude, latitude, _) {
            //if (_alignCamera) {
              setState(() {
                _currentLongtitude = longtitude;
              });
            //}
            if (latitude != 0 && (alignLatitude - latitude).abs()  <= latlonDelta.dy) {
              setState(() => _alignCamera = false);
            } else {
              setState(() => _alignCamera = true);
            }
          }
        )
      ),
    );
  }
}
