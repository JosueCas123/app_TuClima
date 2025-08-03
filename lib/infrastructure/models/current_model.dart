import 'condition_model.dart';

class CurrentModel {
  final double tempC;
  final int isDay;
  final ConditionModel condition;
  final double windKph;
  final int humidity;
  final double feelslikeC;
  final double uv;

  CurrentModel({
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.humidity,
    required this.feelslikeC,
    required this.uv,
  });

  factory CurrentModel.fromJson(Map<String, dynamic> json) => CurrentModel(
        tempC: json['temp_c']?.toDouble(),
        isDay: json['is_day'],
        condition: ConditionModel.fromJson(json['condition']),
        windKph: json['wind_kph']?.toDouble(),
        humidity: json['humidity'],
        feelslikeC: json['feelslike_c']?.toDouble(),
        uv: json['uv']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'temp_c': tempC,
        'is_day': isDay,
        'condition': condition.toJson(),
        'wind_kph': windKph,
        'humidity': humidity,
        'feelslike_c': feelslikeC,
        'uv': uv,
      };
}