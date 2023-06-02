// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/exceptions/weather_exception.dart';
import 'package:weather_app/models/direct_geocoding.dart';
import 'package:weather_app/services/http_error_handler.dart';
import '../data/constants/constants.dart';

class WeatherApiService {
  final http.Client httpClient;
  WeatherApiService({
    required this.httpClient,
  });

  Future<DirectGeocoding> getDirectGeoCoding(String city) async {
    // Uri use the constants value in the constants.dart file.
    final Uri uri = Uri(
        scheme: 'https',
        host: kApiHost,
        path: '/geo/1.0/direct',
        queryParameters: {
          'q': city,
          'limit': kLimit,
          'appid': dotenv.env['APPID']
        });
    try {
      // Create new variable to takes the HTTP Response.
      final http.Response httpResponse = await httpClient.get(uri);
      if (httpResponse != 200) {
        throw httpErrorHandler(httpResponse);
      }

      final responseBody = json.decode(httpResponse.body);

      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the location of the $city');
      }

      final directGeocoding = DirectGeocoding.fromJson(responseBody);

      return directGeocoding;
    } catch (error) {
      rethrow;
    }
  }
}
