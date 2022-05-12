import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:panorama/panorama.dart';

import './models.dart';
import 'HotSpotButton.dart';

class PanoPage extends StatefulWidget {
  final String tourId;
  const PanoPage({ Key? key, required this.tourId }): super(key: key);

  @override
  _PanoPageState createState() => _PanoPageState();
}

class _PanoPageState extends State<PanoPage>{
  late Future<dynamic> _tourFetchResult;
  late TourDetail _tourDetail;
  late SceneDetail? _currentScene;

  Future<http.Response> _getTourDetail() async {
    final response = await http.get(Uri.parse('http://192.168.1.44:8080/tours/${widget.tourId}'));
    
    if (response.statusCode == 200) {
      final tour = TourDetail.fromJson(jsonDecode(response.body));
      setState(() {
        _tourDetail = tour;
        _currentScene = _findScene(tour.defaultScene!.firstScene);
      });
      return response;
    }
    else {
      throw Exception("Failed to load tour detail");
    }
  }

  SceneDetail? _findScene(String sceneId) {
    return _tourDetail.scenes!.firstWhere((scene) => scene.sceneId == sceneId);
  }

  List<Hotspot> _getHotSpots() {
    return _currentScene!.hotspots.map(
      (hotspot) => Hotspot(
        latitude: hotspot.latitude, longitude: hotspot.longtitude, 
        width: 100, height: 100, 
        widget: HotSpotButton(
          title: 'test', 
          onPressed:  () {
            setState(() {
              _currentScene = _findScene(hotspot.sceneId);
            });
          },
          onDelete: () async => _handleHotSpotDeleted(hotspot.sceneId),
        )
      )
    ).toList();
  }

  void _handleHotSpotDeleted(String sceneId) async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.44:8080/hotspots'), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"tourId": _tourDetail.tourId, "sceneFrom": _currentScene?.sceneId, "sceneTo": sceneId })
    );

    final body = jsonDecode(response.body);
    if (body['modifiedCount'] > 0) {
      setState(() => _currentScene!.hotspots.removeWhere((hotspot) => hotspot.sceneId == sceneId));
    }
  }

  @override
  void initState() {
    super.initState();
    _tourFetchResult = _getTourDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: _tourFetchResult, builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Panorama(
            child: Image.network("http://192.168.1.44:8080/images/${_currentScene!.panorama}"),
            hotspots: _getHotSpots(), 
          );
        }
        else {
          return const Text('Loading...');
        }
      })
    );
  }
}