// Dart
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
// Appliaction 
import 'package:frontend_flutter/models.dart';

class ImageRepository {
  static String entrypoint = 'http://192.168.1.44:8080/images';

  Future<UpdateResult> sendImage(String tourId, Uint8List bytes, String filename, MediaType contentType) async {
    final formData = FormData.fromMap({
      "image": MultipartFile.fromBytes(bytes, filename: filename, contentType: contentType),
      "tourId": tourId
    });
    
    final response = await Dio().post(
      entrypoint, 
      data: formData
    );
    return UpdateResult.fromJson(response.data);
  }
}