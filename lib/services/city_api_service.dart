import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/data/constants/constants.dart';
import 'package:weather_app/data/exceptions/weather_exception.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/services/http_error_handler.dart';

class CityService {
  final http.Client httpClient;

  CityService({required this.httpClient});

  Future<List<City>> getAllCity() async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kCityHost,
      path: '/convert/$kCityId/$kCityJson',
    );

    try {
      final http.Response httpResponse = await httpClient.get(uri);

      if (httpResponse.statusCode != 200) {
        throw httpErrorHandler(httpResponse);
      }

      final responseBody = json.decode(httpResponse.body);

      print('responseBody : ${responseBody}');

      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the City');
      }

      List<City> allCity = [];

      for (var item in responseBody) {
        allCity.add(City.fromJson(item));
      }

      print('All City : $allCity');
      return allCity;
    } catch (e) {
      rethrow;
    }
  }
}
