import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/city/city_cubit.dart';
import 'package:weather_app/cubits/search/search_cubit.dart';
import 'package:weather_app/cubits/weather/weather_cubit.dart';
import 'package:weather_app/pages/homepage.dart';
import 'package:weather_app/repository/city_repository.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/services/city_api_service.dart';
import 'package:weather_app/services/weather_api_services.dart';
import 'package:http/http.dart' as http;

void main() async {
  // Load the .env file
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeatherRepository>(
            create: (context) => WeatherRepository(
                weatherApiService:
                    WeatherApiService(httpClient: http.Client()))),
        RepositoryProvider<CityRepository>(
            create: (context) => CityRepository(
                cityService: CityService(httpClient: http.Client()))),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
                weatherRepository: context.read<WeatherRepository>()),
          ),
          BlocProvider<CityCubit>(
            create: (context) =>
                CityCubit(cityRepository: context.read<CityRepository>()),
          ),
          BlocProvider<SearchCubit>(
            lazy: true,
            create: (context) =>
                SearchCubit(cityCubit: context.read<CityCubit>()),
          ),
        ],
        child: MaterialApp(home: HomePage()),
      ),
    );
  }
}
