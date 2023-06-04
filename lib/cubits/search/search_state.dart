// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

class SearchState extends Equatable {
  String searchTerm;
  List<String> countryFilter;
  List<City> filteredCity;


  SearchState({
    required this.searchTerm,
    required this.countryFilter,
    required this.filteredCity,
  });

  factory SearchState.initial() {
    return SearchState(searchTerm: '', countryFilter: [], filteredCity: []);
  }

  SearchState copyWith({
    String? searchTerm,
    List<String>? countryFilter,
    List<City>? filteredCity,
  }) {
    return SearchState(
      searchTerm: searchTerm ?? this.searchTerm,
      countryFilter: countryFilter ?? this.countryFilter,
      filteredCity: filteredCity ?? this.filteredCity,
    );
  }

  @override
  List<Object> get props => [searchTerm, countryFilter, filteredCity];

  @override
  bool get stringify => true;
}
