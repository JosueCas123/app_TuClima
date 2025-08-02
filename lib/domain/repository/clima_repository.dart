

import 'package:app_tuclima/domain/entities/weather_entity.dart';


abstract class ClimasRepository {
//  Future<WeatherEntity> getForecast(String city);
//   Future<List<WeatherEntity>> getPastSevenDaysForecast(String city);
   Future<Map<String, dynamic>> getForecast(String city);
  Future<List<Map<String, dynamic>>> getPastSevenDaysForecast(String city);
}