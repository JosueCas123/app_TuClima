

import 'package:app_tuclima/domain/entities/weather_entity.dart';


abstract class ClimasDatasource {
 Future<Map<String, dynamic>> getForecast(String city);
  Future<List<Map<String, dynamic>>> getPastSevenDaysForecast(String city);
//  Future<WeatherEntity> getForecast(String city);
//   Future<List<WeatherEntity>> getPastSevenDaysForecast(String city);
}