// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather_app/data/exceptions/weather_exception.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/services/city_api_service.dart';

class CityRepository {
  final CityService cityService;
  CityRepository({
    required this.cityService,
  });

  Future<List<City>> fetchAllCity() async {
    try {
      final List<City> allCity = await cityService.getAllCity();

      print('allCity : $allCity');

      return allCity;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (err) {
      throw CustomError(errMsg: err.toString());
    }
  }
}
