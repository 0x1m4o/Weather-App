import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/custom_error.dart';
import 'package:weather_app/repository/city_repository.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  final CityRepository cityRepository;

  CityCubit({required this.cityRepository}) : super(CityState.initial());

  Future<void> fetchAllCity() async {
    try {
      final List<City> allCity = await cityRepository.fetchAllCity();
      emit(state.copyWith(cityList: allCity));
    } catch (error) {
      CustomError(errMsg: error.toString());
    }
  }
}
