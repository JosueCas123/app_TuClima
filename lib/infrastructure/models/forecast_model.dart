import 'forecast_day_model.dart';

class ForecastModel {
  final List<ForecastDayModel> forecastDays;

  ForecastModel({required this.forecastDays});

  factory ForecastModel.fromJson(Map<String, dynamic> json) => ForecastModel(
        forecastDays: (json['forecastday'] as List)
            .map((e) => ForecastDayModel.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'forecastday': forecastDays.map((e) => e.toJson()).toList(),
      };
}