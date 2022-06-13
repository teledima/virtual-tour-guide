// Dart
import 'dart:convert';
import 'package:http/http.dart' as http;
// Flutter
import 'package:flutter_dotenv/flutter_dotenv.dart';
// Application
import 'package:frontend_flutter/models.dart';

class TourRepository {
  static String entrypoint = '${dotenv.env["SERVER_ENTRYPOINT"]}/tours';

  Future<List<TourDetail>> fetchTours() async {
    final response = await http.get(Uri.parse('$entrypoint/all'));
    
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return [for (var tour in json) TourDetail.fromJson(tour)];
    } else {
      throw Exception("Failed to load tours list");
    }
  } 

  Future<TourDetail> fetchTour(String tourId) async {
    final response = await http.get(Uri.parse('$entrypoint/$tourId'));
    
    if (response.statusCode == 200) {
      final tour = TourDetail.fromJson(jsonDecode(response.body));
      return tour;
    }
    else {
      throw Exception("Failed to load tour detail");
    }
  }

  Future<UpdateResult> updateDefaultScene(String tourId, String sceneId) async{
    final response = await http.patch(
      Uri.parse(entrypoint),
      headers: {'Content-Type': 'application/json'}, 
      body: jsonEncode({
        "tourId": tourId,
        "updateBody": { "default": {"firstScene": sceneId} }
      }),
    );

    if (response.statusCode == 200) {
      return UpdateResult.fromJson(jsonDecode(response.body));
    }
    else {
      throw Exception("Failed to load tour detail");
    }
  }
}
