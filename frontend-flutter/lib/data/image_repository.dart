// Dart
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class ImageRepository {
  static String entrypoint = 'http://192.168.1.44:8080/images';

  Future<Response> sendImage(Uint8List bytes, String filename, MediaType contentType) async {
    final formData = FormData.fromMap({
      "image": MultipartFile.fromBytes(bytes, filename: filename, contentType: contentType),
    });
    
    return Dio().post(
      entrypoint, 
      data: formData
    );
  }
}