// Dart
import 'dart:convert';
// Flutter
import 'package:http/http.dart' as http;
// Application
import 'package:frontend_flutter/models.dart';

class HotspotRepository {
  static String serverName = 'http://192.168.1.44:8080';

  Future<UpdateResult> deleteHotspot(TourDetail tour, SceneDetail currentScene, HotspotDetail hotspot) async{
    final response = await http.delete(
      Uri.parse('$serverName/hotspots'), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"tourId": tour.tourId, "sceneFrom": currentScene.sceneId, "sceneTo": hotspot.sceneId })
    );

    return UpdateResult.fromJson(jsonDecode(response.body));
  }

  Future<UpdateResult> moveHotspot(
    TourDetail tour, SceneDetail currentScene, HotspotDetail hotspot, 
    double newLatitude, double newLongtitude
  ) async {
    final response = await http.patch(
      Uri.parse('$serverName/hotspots'), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "tourId": tour.tourId, 
        "sceneFrom": currentScene.sceneId, 
        "sceneTo": hotspot.sceneId,
        "latitude": newLatitude,
        "longtitude": newLongtitude
      })
    );

    return UpdateResult.fromJson(jsonDecode(response.body));
  } 
}