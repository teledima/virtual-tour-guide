// Dart
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
// Flutter
import 'package:flutter_dotenv/flutter_dotenv.dart';
// Appliaction 
import 'package:frontend_flutter/models.dart';

class ScenesRepository {
  static String entrypoint = '${dotenv.env["SERVER_ENTRYPOINT"]}/scenes';

  Future<UpdateResult> create(String tourId, Uint8List bytes, String sceneName, MediaType contentType) async {
    final formData = FormData.fromMap({
      "image": MultipartFile.fromBytes(bytes, filename: sceneName, contentType: contentType),
      "tourId": tourId
    });
    
    final response = await Dio().post(
      entrypoint, 
      data: formData
    );
    return UpdateResult.fromJson(response.data);
  }
}
