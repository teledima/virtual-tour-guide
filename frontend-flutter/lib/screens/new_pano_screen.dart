import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
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
  late List<PhotoInfo> _photos_cache;
  late List<HotspotInfo> _hotspots;
  late bool _alignCamera;
  late bool _activeButton;
  late double _currentLatitude;
  late double _currentLongtitude;
  late bool _reverse;
  late bool _isDone;

  final Offset latlonDelta = const Offset(1, 1);
  final double alignLatitude = 0;
  final double previewWidth = 180;
  final double angle = 15;

  get previewHeight {
    if (_controller.value.isInitialized) {
      return _controller.value.aspectRatio * previewWidth;
    } else {
      return 0;
    }
  }

  double mod(double a, double b) {
    return a - (a / b).floor() * b;
  }

  Future<Uint8List> makePhoto() async {
    final image = await _controller.takePicture();
    return image.readAsBytes();
  }

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      GetIt.I.get<CameraDescription>(), 
      ResolutionPreset.medium,
      enableAudio: false
    );
    _photos_cache = [];
    _hotspots = [];
    _initializeControllerFuture = _controller.initialize();
    _alignCamera = true;
    _activeButton = false;
    _currentLongtitude = 0;
    _currentLatitude = 0;
    _reverse = true;
    _isDone = false;
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
          reverse: _reverse,
          sensorControl: SensorControl.Orientation,
          child: Image.asset('assets/black_image.jpg'),
          hotspots: [ 
            for (PhotoInfo photo in _photos_cache) 
              Hotspot(
                latitude: photo.latitude,
                longitude: photo.longitude,
                width: previewWidth, 
                height: previewHeight,
                widget: AspectRatio(
                  aspectRatio: 1/_controller.value.aspectRatio, 
                  child: Image.memory(photo.photo),
                )
              ),
            if (_alignCamera) Hotspot(
              longitude: _currentLongtitude,
              latitude: alignLatitude,
              widget: Icon(Icons.circle_sharp, color: !_activeButton ? Colors.red : Colors.blue, size: 50,)
            ) 
            else 
              for (HotspotInfo hotspot in _hotspots) 
                Hotspot(
                  latitude: hotspot.latitude,
                  longitude: hotspot.longitude,
                  widget: Icon(
                    Icons.circle_sharp, 
                    color: !hotspot.isActive ? Colors.red : Colors.blue, size: 50,
                    semanticLabel: '${hotspot.longitude}',
                  )
                )
          ],
          staticChildren: [
            // camera preview
            if (!_isDone)
              Positioned(
                top: (constraints.maxHeight - previewHeight) / 2,
                left: (constraints.maxWidth - previewWidth) / 2,
                width: previewWidth,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1, 
                      child: FutureBuilder(
                        future: _initializeControllerFuture, 
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (_alignCamera) {
                              return AspectRatio(aspectRatio: 1/_controller.value.aspectRatio, child:  CameraPreview(_controller));
                            } else {
                              return AspectRatio(
                                aspectRatio: 1/_controller.value.aspectRatio, 
                                child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 2)))
                              );
                            }
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                      )
                    )
                  ]
                )
              ),
            // navigate hotspots
            if (!_isDone)
              Positioned(
                top: (constraints.maxHeight - 58) / 2,
                left: (constraints.maxWidth - 58) / 2,
                child: const Icon(Icons.circle_outlined, color: Colors.orange, size: 75,)
              ),
            // photo icon
            if (_activeButton && !_isDone) Positioned(
              bottom: 10,
              left: (constraints.maxWidth - 50) / 2,
              child: IconButton(
                onPressed: () async {
                  final photo = await makePhoto();
                  setState(() { 
                    double newLatitude = alignLatitude;
                    late double photoLongtitude;
                    late double newLongtitude;

                    if (_alignCamera) {
                      _alignCamera = false;
                      _reverse = false;
                      photoLongtitude = _currentLongtitude;
                    } else {
                      final idx = _hotspots.indexWhere((hotspot) => hotspot.isActive);

                      photoLongtitude = _hotspots[idx].longitude;
                      _hotspots.removeAt(idx);                      
                    }

                    if (photoLongtitude + angle >= 0 && photoLongtitude + angle <= 180) {
                      newLongtitude = mod(photoLongtitude + angle, 180);
                    } else {
                      // own modulo implementation
                      newLongtitude =  mod(photoLongtitude + angle, -180);
                    }
                    
                    
                    _photos_cache.add(PhotoInfo(photo, alignLatitude, photoLongtitude));
                    if (_photos_cache.length == 360 / angle) {
                      _isDone = true;
                    } else {
                      _hotspots.add(HotspotInfo(newLatitude, newLongtitude, false));
                    }
                  });
                },
                icon: const Icon(Icons.photo_camera, color: Colors.white, size: 50,),
              )
            ),
            if (_isDone)
              Positioned(
                bottom: 10,
                left: (constraints.maxWidth - 50) / 2,
                child: IconButton(
                  icon: const Icon(Icons.check, color: Colors.white, size: 50,),
                  onPressed: () async {
                    final output = XFile.fromData((await rootBundle.load('assets/output.jpg')).buffer.asUint8List(), name: 'output');
                    Navigator.of(context).pop(output);
                  },
                )
              ),
            // lat lon measures
            Positioned(
              bottom: 10,
              left: 0,
              height: 100,
              width: 50,
              child: Column(children: [
                Text(_currentLatitude.toStringAsFixed(1), style: TextStyle(color: Colors.blue),),
                Text(_currentLongtitude.toStringAsFixed(1), style: TextStyle(color: Colors.blue),)
              ],)
            )
          ],
          onViewChanged: (longtitude, latitude, _) {
            setState(() {
              _currentLongtitude = longtitude;
              _currentLatitude = latitude;
            });

            if (_alignCamera) {
              if (latitude != 0 && (alignLatitude - latitude).abs()  <= latlonDelta.dy) {
                setState(() => _activeButton = true);
              } else {
                setState(() => _activeButton = false);
              }
            } else {
              final idx = _hotspots.indexWhere(
                (hotspot) => (hotspot.longitude - longtitude).abs()  <= latlonDelta.dx && (hotspot.latitude - latitude).abs()  <= latlonDelta.dy
              );
              if (idx != -1) {
                setState(() { 
                  _hotspots[idx] = _hotspots[idx].copyWith(isActive: true);
                  _activeButton = true;
                });
              } else {
                setState(() {
                  _hotspots = _hotspots.map((e) => e.copyWith(isActive: false)).toList();
                  _activeButton = false;
                });
              }
            }
            
          }
        )
      ),
    );
  }
}

class PhotoInfo {
  Uint8List photo;
  double latitude;
  double longitude;

  PhotoInfo(this.photo, this.latitude, this.longitude);
}

class HotspotInfo {
  double latitude;
  double longitude;
  bool isActive;

  HotspotInfo(this.latitude, this.longitude, this.isActive);

  HotspotInfo copyWith({
    double? latitude, 
    double? longitude, 
    bool? isActive
  }) {
    return HotspotInfo(latitude ?? this.latitude, longitude ?? this.longitude, isActive ?? this.isActive);
  }
}