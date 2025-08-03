import 'condition_entity.dart';

class ForecastDayEntity {
  final DateTime date;
  final double maxTempC;
  final double minTempC;
  final ConditionEntity condition;

  ForecastDayEntity({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.condition,
  });
}