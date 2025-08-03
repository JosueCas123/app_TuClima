import 'location_model.dart';
import 'current_model.dart';
import 'forecast_model.dart';
import 'condition_model.dart';

class ClimaLocationModel {
  final LocationModel location;
  final CurrentModel current;
  final ForecastModel forecast;
  final List<HourlyForecastModel> hourly;

  ClimaLocationModel({
    required this.location,
    required this.current,
    required this.forecast,
    required this.hourly,
  });

  factory ClimaLocationModel.fromJson(Map<String, dynamic> json) {
    final forecastday = json['forecast']['forecastday'] as List;
    final hourly = forecastday.isNotEmpty
        ? (forecastday[0]['hour'] as List)
            .map((e) => HourlyForecastModel.fromJson(e))
            .toList()
        : <HourlyForecastModel>[];

    return ClimaLocationModel(
      location: LocationModel.fromJson(json['location']),
      current: CurrentModel.fromJson(json['current']),
      forecast: ForecastModel.fromJson(json['forecast']),
      hourly: hourly,
    );
  }

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'current': current.toJson(),
        'forecast': forecast.toJson(),
        'hourly': hourly.map((e) => e.toJson()).toList(),
      };
}

class HourlyForecastModel {
  final String time;
  final double tempC;
  final ConditionModel condition;
  final int chanceOfRain;

  HourlyForecastModel({
    required this.time,
    required this.tempC,
    required this.condition,
    required this.chanceOfRain,
  });

  factory HourlyForecastModel.fromJson(Map<String, dynamic> json) =>
      HourlyForecastModel(
        time: json['time'],
        tempC: json['temp_c']?.toDouble(),
        condition: ConditionModel.fromJson(json['condition']),
        chanceOfRain: json['chance_of_rain'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'time': time,
        'temp_c': tempC,
        'condition': condition.toJson(),
        'chance_of_rain': chanceOfRain,
      };
}