class LocationModel {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;

  LocationModel({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        name: json['name'],
        region: json['region'],
        country: json['country'],
        lat: json['lat']?.toDouble(),
        lon: json['lon']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'region': region,
        'country': country,
        'lat': lat,
        'lon': lon,
      };
}