// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String cityName;
  final String country;
  final String lat;
  final String lon;
  City({
    required this.cityName,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory City.fromJson(Map<String, dynamic> data) {
    return City(
      cityName: data['name'],
      country: data['country'],
      lat: data['lat'],
      lon: data['lon'],
    );
  }

  factory City.initial() =>
      City(cityName: '', country: '', lat: '100.0', lon: '100.0');

  @override
  List<Object> get props => [cityName, country, lat, lon];

  @override
  bool get stringify => true;

  City copyWith({
    String? cityName,
    String? country,
    String? lat,
    String? lon,
  }) {
    return City(
      cityName: cityName ?? this.cityName,
      country: country ?? this.country,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }
}
