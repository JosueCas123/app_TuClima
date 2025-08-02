

import 'package:app_tuclima/config/constants/enviroment.dart';
import 'package:app_tuclima/domain/datasource/clima_datasource.dart';
import 'package:app_tuclima/domain/entities/weather_entity.dart';
import 'package:app_tuclima/infrastructure/models/weather_response_model.dart';
import 'package:dio/dio.dart';

class ClimaDatasource extends ClimasDatasource {

   final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.weatherapi.com/v1',
      queryParameters: {
        'key': Environment.weatherapiKey, // 
        'lang': 'es', // 
      },
    ),
  );

  @override
  Future<Map<String, dynamic>> getForecast(String city) async {

      final response = await dio.get('/forecast.json', queryParameters: {
        'q': city,
        'days': 7,
      });

       if (response.statusCode != 200) {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }

    final data = response.data;
print('Forecast data: ${response.data}');

    if (data.containsKey('error')) {
      throw Exception('API Error: ${data['error']['message']}');
    }

    return data;
  }
  
  @override
  Future<List<Map<String, dynamic>>> getPastSevenDaysForecast(String city) async {
    final List<Map<String, dynamic>> pastWeather = [];
    final now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      final date = now.subtract(Duration(days: i));
      final formatDate =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

      final response = await dio.get(
        'https://api.weatherapi.com/v1/history.json',
        queryParameters: {
          'key': Environment.weatherapiKey,
          'q': city,
          'dt': formatDate,
          'lang': 'es',
        },
      );

      if (response.statusCode == 200 && !response.data.containsKey('error')) {
        pastWeather.add(response.data);
      }
    }

    return pastWeather;
  }
   
  }


