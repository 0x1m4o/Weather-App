import 'package:flutter/material.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/services/weather_api_services.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _fetchApi();
  }

  _fetchApi() {
    WeatherRepository(
            weatherApiService: WeatherApiService(httpClient: http.Client()))
        .fetchWeather('Jakarta');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
    );
  }
}
