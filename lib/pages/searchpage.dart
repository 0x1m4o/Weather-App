import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/city/city_cubit.dart';
import 'package:weather_app/cubits/search/search_cubit.dart';
import 'package:weather_app/cubits/weather/weather_cubit.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/pages/homepage.dart';
import 'package:weather_app/repository/city_repository.dart';
import 'package:weather_app/services/city_api_service.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController editingController = TextEditingController();
  @override
  void initState() {
    if (context.read<SearchCubit>().state.searchTerm.isNotEmpty) {
      editingController.text = context.read<SearchCubit>().state.searchTerm;
    }

    super.initState();
  }

  Widget build(BuildContext context) {
    List<dynamic> allCity = context.watch<CityCubit>().state.cityList;
    Set<String> uniqueCountries = {};

    for (var city in allCity) {
      uniqueCountries.add(city.country);
    }
    List<String> countryNames = uniqueCountries.toList();

    List<City> filteredCities = context.watch<SearchCubit>().state.filteredCity;
    var textFieldValue = editingController.text;

    return SafeArea(
      child: Scaffold(
        body: allCity.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: editingController,
                      onChanged: (value) {
                        context
                            .read<SearchCubit>()
                            .setFiltered(countryNames, editingController.text);
                      },
                      decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: ListView.builder(
                          itemCount: filteredCities.isEmpty
                              ? allCity.length
                              : filteredCities.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 4),
                              child: Card(
                                child: ListTile(
                                  onTap: () {
                                    filteredCities.isEmpty
                                        ? context
                                            .read<WeatherCubit>()
                                            .fetchData(allCity[index].cityName)
                                        : context
                                            .read<WeatherCubit>()
                                            .fetchData(
                                                filteredCities[index].cityName);
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return HomePage();
                                      },
                                    ));
                                  },
                                  title: Text(filteredCities.isEmpty
                                      ? allCity[index].cityName
                                      : filteredCities[index].cityName),
                                  subtitle: Text(filteredCities.isEmpty
                                      ? allCity[index].country
                                      : filteredCities[index].country),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
