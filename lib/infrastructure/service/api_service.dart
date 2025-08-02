import 'package:app_tuclima/config/constants/enviroment.dart';
import 'package:dio/dio.dart';

class WeatherApiService {
  Future<List<Map<String, dynamic>>> getHourlyForecast(String city) async {
    final response = await Dio().get(
      'https://api.weatherapi.com/v1/forecast.json',
      queryParameters: {
        'key': Environment.weatherapiKey,
        'q': city,
        'days': 7,
        'lang': 'es',
      },
    );

    if (response.statusCode == 200) {
      throw Exception('Failed to  fetch data: ${response.statusCode}');
    }
    final data = response.data;
    if (data.containsKey('error')) {
      throw Exception('Failed to fetch data: ${data['error']['message']}');
    }

    return data;
  }

  Future<List<Map<String, dynamic>>> getOastSevenDaysForecast(
    String city,
  ) async {
    final List<Map<String, dynamic>> posterWeather = [];
    final today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      final date = today.subtract(Duration(days: i));
      final formatDate =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final response = await Dio().get(
        'https://api.weatherapi.com/v1/history.json',
        queryParameters: {
          'key': Environment.weatherapiKey,
          'q': city,
          'dt': formatDate,
          'lang': 'es',
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data.containsKey('error')) {
          throw Exception('Failed to fetch data: ${data['error']['message']}');
        }
        if (data['forecast']?['forecastday'] != null) {
          posterWeather.add(data);
        }
      } else {
        throw Exception('Failed to fetch data for $formatDate: ${response.statusCode}');
      }
    }
    return posterWeather;
  }
}
