import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocalPaths {
  static String get placeHolderCast => dotenv.get('BASE_URL', fallback: null);
  static String get placeHolderPosterMovie =>
      dotenv.get('PLACEHOLDER_POSTER_MOVIE', fallback: null);
}
