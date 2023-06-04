// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String description;
  final String icon;
  final String name;
  final String country;
  final double temp;
  final double tempMin;
  final double tempMax;
  final double windSpeed;
  final int humidity;
  final int pressure;
  final DateTime lastUpdated;

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    final wind = json['wind'];

    return Weather(
        description: weather['description'],
        icon: weather['icon'],
        name: '',
        country: '',
        temp: main['temp'],
        tempMin: main['temp_min'],
        tempMax: main['temp_max'],
        humidity: main['humidity'],
        pressure: main['pressure'],
        windSpeed: wind['speed'],
        lastUpdated: DateTime.now());
  }

  factory Weather.initial() => Weather(
      description: '',
      icon: '',
      name: '',
      country: '',
      temp: 100.0,
      tempMin: 100.0,
      tempMax: 100.0,
      windSpeed: 100.0,
      humidity: 10,
      pressure: 10,
      lastUpdated: DateTime(1970));

  Weather({
    required this.description,
    required this.icon,
    required this.name,
    required this.country,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.windSpeed,
    required this.humidity,
    required this.pressure,
    required this.lastUpdated,
  });

  @override
  List<Object> get props {
    return [
      description,
      icon,
      name,
      country,
      temp,
      tempMin,
      tempMax,
      windSpeed,
      humidity,
      pressure,
      lastUpdated,
    ];
  }

  @override
  String toString() {
    return 'Weather(description: $description, icon: $icon, temp: $temp, tempMin: $tempMin, tempMax: $tempMax, name: $name, country: $country, lastUpdated: $lastUpdated)';
  }

  Weather copyWith({
    String? description,
    String? icon,
    String? name,
    String? country,
    double? temp,
    double? tempMin,
    double? tempMax,
    double? windSpeed,
    int? humidity,
    int? pressure,
    DateTime? lastUpdated,
  }) {
    return Weather(
      description: description ?? this.description,
      icon: icon ?? this.icon,
      name: name ?? this.name,
      country: country ?? this.country,
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      windSpeed: windSpeed ?? this.windSpeed,
      humidity: humidity ?? this.humidity,
      pressure: pressure ?? this.pressure,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
