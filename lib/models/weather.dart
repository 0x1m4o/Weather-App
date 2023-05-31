import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String description;
  final String icon;
  final String name;
  final String country;
  final double temp;
  final double tempMin;
  final double tempMax;
  final DateTime lastUpdated;

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];

    return Weather(
        description: weather['description'],
        icon: weather['icon'],
        name: '',
        country: '',
        temp: main['temp'],
        tempMin: main['temp_min'],
        tempMax: main['temp_max'],
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
      lastUpdated: DateTime(1970));

  Weather({
    required this.description,
    required this.icon,
    required this.name,
    required this.country,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
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
      lastUpdated,
    ];
  }

  @override
  bool get stringify => true;
}
