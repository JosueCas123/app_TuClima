
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static  String weatherapiKey = dotenv.env['THE_WEATHER_API_KEY'] ?? 'NO_API_KEY';
}