import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String get baseUrl => _readEnv(
        'FUJI_BASE_URL',
        fallback: 'https://fuji.technology/wp-json/wc/v3',
      );

  static String get productsApiUrl => '$baseUrl/products?per_page=50&page=1';

  static String get ckUsername => _readEnv('FUJI_WC_CONSUMER_KEY');

  static String get csPassword => _readEnv('FUJI_WC_CONSUMER_SECRET');

  static String _readEnv(String key, {String fallback = ''}) {
    final value = dotenv.env[key];
    if (value != null && value.isNotEmpty) {
      return value;
    }
    if (fallback.isNotEmpty) {
      return fallback;
    }
    throw StateError('Missing required environment variable: $key');
  }
}
