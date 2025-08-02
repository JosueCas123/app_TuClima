import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.city,
    required super.condition,
    required super.temperature,
    required super.hourly,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final forecastHour = json['forecast']['forecastday'][0]['hour'];
    final List<HourlyForecast> hourly = forecastHour.map<HourlyForecast>((h) {
      return HourlyForecast(
        time: h['time'],
        tempC: h['temp_c'].toDouble(),
        condition: h['condition']['text'],
      );
    }).toList();

    return WeatherModel(
      city: json['location']['name'],
      condition: json['current']['condition']['text'],
      temperature: json['current']['temp_c'].toDouble(),
      hourly: hourly,
    );
  }
}
