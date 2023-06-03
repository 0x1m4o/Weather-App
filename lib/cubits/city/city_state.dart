// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'city_cubit.dart';

class CityState extends Equatable {
  final List<City> cityList;

  CityState({required this.cityList});

  factory CityState.initial() {
    return CityState(cityList: []);
  }

  @override
  List<Object?> get props => [cityList];

  CityState copyWith({
    List<City>? cityList,
  }) {
    return CityState(
      cityList: cityList ?? this.cityList,
    );
  }
}
