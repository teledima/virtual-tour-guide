// Dart
import 'dart:convert';
// Flutter
import 'package:http/http.dart' as http;
// Application
import 'package:frontend_flutter/models.dart';

class TourRepository {
  static String entrypoint = 'http://192.168.1.44:8080/tours';

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
}