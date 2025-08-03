import 'condition_model.dart';

class ForecastDayModel {
  final DateTime date;
  final double maxTempC;
  final double minTempC;
  final ConditionModel condition;

  ForecastDayModel({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.condition,
  });

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) {
    final day = json['day'];
    return ForecastDayModel(
      date: DateTime.parse(json['date']),
      maxTempC: day['maxtemp_c']?.toDouble(),
      minTempC: day['mintemp_c']?.toDouble(),
      condition: ConditionModel.fromJson(day['condition']),
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'day': {
          'maxtemp_c': maxTempC,
          'mintemp_c': minTempC,
          'condition': condition.toJson(),
        },
      };
}