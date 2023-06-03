// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather_app/data/exceptions/weather_exception.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/direct_geocoding.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiService weatherApiService;
  WeatherRepository({
    required this.weatherApiService,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherApiService.getDirectGeoCoding(city);
      print('directGeocoding: $directGeocoding');

      final Weather tempWeather =
          await weatherApiService.getWeather(directGeocoding);

      final Weather weather = tempWeather.copyWith(
          name: directGeocoding.name, country: directGeocoding.country);

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (err) {
      throw CustomError(errMsg: err.toString());
    }
  }
}
