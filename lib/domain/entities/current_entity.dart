import 'condition_entity.dart';

class CurrentEntity {
  final double tempC;
  final int isDay;
  final ConditionEntity condition;
  final double windKph;
  final int humidity;
  final double feelslikeC;
  final double uv;

  CurrentEntity({
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.humidity,
    required this.feelslikeC,
    required this.uv,
  });
}