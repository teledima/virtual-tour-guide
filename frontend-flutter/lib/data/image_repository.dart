import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageRepository {
  static String entrypoint = '${dotenv.env["SERVER_ENTRYPOINT"]}/images';
}
