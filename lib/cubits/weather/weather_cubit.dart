import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/weather_repository.dart';


part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());

  void fetchData(String city) async {
    try {
      final Weather weather = await weatherRepository.fetchWeather(city);
      emit(state.copyWith(weather: weather, status: WeatherStatus.loaded));
      print(state);
    } on CustomError catch (e) {
      emit(state.copyWith(error: e, status: WeatherStatus.error));
    }
  }
}
