import 'package:app_tuclima/domain/entities/forecast_day_entity.dart';
import 'package:app_tuclima/infrastructure/models/condition_model.dart';
import 'package:app_tuclima/infrastructure/models/current_model.dart';
import 'package:app_tuclima/infrastructure/models/forecast_model.dart';
import 'package:app_tuclima/infrastructure/models/location_model.dart';

import '../../domain/entities/clima_location_entity.dart';
import '../../domain/entities/current_entity.dart';
import '../../domain/entities/condition_entity.dart';
import '../../domain/entities/forecast_entity.dart';
import '../../domain/entities/location_entity.dart';
import '../models/clima_location_model.dart';

class ClimaMapper {
  static ClimaLocationEntity toEntity(ClimaLocationModel model) {
    return ClimaLocationEntity(
      location: _mapLocation(model.location),
      current: _mapCurrent(model.current),
      forecast: _mapForecast(model.forecast),
      hourly: _mapHourly(model.hourly),
    );
  }

  static LocationEntity _mapLocation(LocationModel model) {
    return LocationEntity(
      name: model.name,
      region: model.region,
      country: model.country,
      lat: model.lat,
      lon: model.lon,
    );
  }

  static ConditionEntity _mapCondition(ConditionModel model) {
    return ConditionEntity(
      text: model.text,
      iconUrl: "https:${model.icon}", // Convertir a URL completa
      code: model.code,
    );
  }

  static CurrentEntity _mapCurrent(CurrentModel model) {
    return CurrentEntity(
      tempC: model.tempC,
      isDay: model.isDay,
      condition: _mapCondition(model.condition),
      windKph: model.windKph,
      humidity: model.humidity,
      feelslikeC: model.feelslikeC,
      uv: model.uv,
    );
  }

  static ForecastEntity _mapForecast(ForecastModel model) {
    return ForecastEntity(
      forecastDays: model.forecastDays.map((day) {
        return ForecastDayEntity(
          date: day.date,
          maxTempC: day.maxTempC,
          minTempC: day.minTempC,
          condition: _mapCondition(day.condition),
        );
      }).toList(),
    );
  }

  static List<HourlyForecastEntity> _mapHourly(List<HourlyForecastModel> hourly) {
    return hourly.map((hour) {
      return HourlyForecastEntity(
        time: DateTime.parse(hour.time),
        tempC: hour.tempC,
        condition: _mapCondition(hour.condition),
        chanceOfRain: hour.chanceOfRain,
      );
    }).toList();
  }
}