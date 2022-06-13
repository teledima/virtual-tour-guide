// Dart
import 'dart:convert';
// Flutter
import 'package:http/http.dart' as http;
// Application
import 'package:frontend_flutter/models.dart';

class HotspotRepository {
  static String entrypoint = 'http://192.168.1.44:8080/hotspots';

  Future<UpdateResult> deleteHotspot(String tourId, String sceneId, HotspotDetail hotspot) async{
    final response = await http.delete(
      Uri.parse(entrypoint), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "tourId": tourId, 
        "sceneId": sceneId, 
        "latitude": hotspot.latitude, 
        "longtitude": hotspot.longtitude 
      })
    );

    return UpdateResult.fromJson(jsonDecode(response.body));
  }

  Future<UpdateResult> moveHotspot(
    String tourId, String sceneId, HotspotDetail hotspot, 
    double newLatitude, double newLongtitude
  ) async {
    final response = await http.patch(
      Uri.parse(entrypoint), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "tourId": tourId, 
        "sceneId": sceneId, 
        "hotspot": hotspot.toJson(),
        "latitude": newLatitude,
        "longtitude": newLongtitude
      })
    );

    return UpdateResult.fromJson(jsonDecode(response.body));
  } 

  Future<UpdateResult> createHotspot(String tourId, String sceneId, HotspotDetail hotspot) async{
    final response = await http.post(
      Uri.parse(entrypoint), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "tourId": tourId, 
        "sceneId": sceneId,
        "hotspot": hotspot.toJson()
      })
    );

    return UpdateResult.fromJson(jsonDecode(response.body));
  }
}
