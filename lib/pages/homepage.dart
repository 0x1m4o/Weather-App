import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/city/city_cubit.dart';
import 'package:weather_app/cubits/weather/weather_cubit.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/weather.dart';
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
    _fetchCity();
  }

  _fetchCity() async {
    List<City> allCities = await CityRepository(
            cityService: CityService(httpClient: http.Client()))
        .fetchAllCity();
    context.read<CityCubit>().fetchAllCity(allCities);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Homepage'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SearchPage();
                    },
                  ));
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: _showWeather(),
      ),
    );
  }

  Widget _showWeather() {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(state.error.errMsg),
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state.status == WeatherStatus.initial) {
          return Center(
            child: Text(
              'Select a City',
              style: TextStyle(fontSize: 20),
            ),
          );
        }

        if (state.status == WeatherStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: Text(
            state.weather.name,
            style: TextStyle(fontSize: 15),
          ),
        );
      },
    );
  }
}
