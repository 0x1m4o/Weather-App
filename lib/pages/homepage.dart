import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather/weather_cubit.dart';
import 'package:weather_app/pages/searchpage.dart';
import 'package:weather_app/repository/city_repository.dart';
import 'package:weather_app/services/city_api_service.dart';
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
    _fetchWeather();
    _fetchCity();
  }

  _fetchWeather() {
    context.read<WeatherCubit>().fetchData('semarang');
  }

  _fetchCity() {
    CityRepository(cityService: CityService(httpClient: http.Client()))
        .fetchAllCity();
  }

  @override
  String? city;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
        actions: [
          IconButton(
              onPressed: () async {
                city = await Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SearchPage();
                  },
                ));
                if (city != null) {
                  context.read<WeatherCubit>().fetchData(city!);
                }
              },
              icon: Icon(Icons.search))
        ],
      ),
    );
  }
}
