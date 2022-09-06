import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRouteConfig {
  static String get baseUrl => dotenv.get('BASE_URL', fallback: null);
  static String get apiKey => dotenv.get('API_KEY', fallback: null);
  static String get baseImgUrl => dotenv.get('BASE_IMAGE_URL', fallback: null);
  static String get language => dotenv.get('LANGUAGE', fallback: null);
  static Future<void> loadEnviroments() async {
    if (kReleaseMode) {
      await dotenv.load(fileName: '.env.production');
    } else {
      await dotenv.load(fileName: '.env.development');
    }
  }
}
