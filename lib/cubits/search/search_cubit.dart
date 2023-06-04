import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/cubits/city/city_cubit.dart';
import 'package:weather_app/models/city.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final CityCubit cityCubit;
  late StreamSubscription streamSubscription;

  SearchCubit({required this.cityCubit}) : super(SearchState.initial()) {
    streamSubscription = cityCubit.stream.listen((CityState) {
      setFiltered([], '');
    });
  }

  void setFiltered(List<String> country, String searchTerm) {
    List<City> filteredCities;
    if (searchTerm.isEmpty) {
      emit(state.copyWith(filteredCity: cityCubit.state.cityList));
    }

    filteredCities = cityCubit.state.cityList
        .where((city) => country.isEmpty || country.contains(city.country))
        .where((city) =>
            city.country.toLowerCase().contains(searchTerm.toLowerCase()) ||
            city.cityName.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();

    emit(state.copyWith(
        countryFilter: country,
        searchTerm: searchTerm,
        filteredCity: filteredCities));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
