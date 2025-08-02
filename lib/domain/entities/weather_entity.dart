class WeatherEntity {
  final String city;
  final String condition;
  final double temperature;
  final List<HourlyForecast> hourly;

  WeatherEntity({
    required this.city,
    required this.condition,
    required this.temperature,
    required this.hourly,
  });
}

class HourlyForecast {
  final String time;
  final double tempC;
  final String condition;

  HourlyForecast({
    required this.time,
    required this.tempC,
    required this.condition,
  });
}
