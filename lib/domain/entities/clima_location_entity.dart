import 'package:app_tuclima/domain/entities/condition_entity.dart';

import 'location_entity.dart';
import 'current_entity.dart';
import 'forecast_entity.dart';

class ClimaLocationEntity {
  final LocationEntity location;
  final CurrentEntity current;
  final ForecastEntity forecast;
  final List<HourlyForecastEntity> hourly;

  ClimaLocationEntity({
    required this.location,
    required this.current,
    required this.forecast,
    required this.hourly,
  });
}

class HourlyForecastEntity {
  final DateTime time;
  final double tempC;
  final ConditionEntity condition;
  final int chanceOfRain;

  HourlyForecastEntity({
    required this.time,
    required this.tempC,
    required this.condition,
    required this.chanceOfRain,
  });
}