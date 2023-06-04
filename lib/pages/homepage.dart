import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather/weather_cubit.dart';
import 'package:weather_app/data/constants/constants.dart';
import 'package:recase/recase.dart';
import 'package:weather_app/routes/pages_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Homepage'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.search);
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: _showWeather(),
      ),
    );
  }

  Widget showDesc(String desc) {
    final formattedDesc = desc.titleCase;
    return Text(
      formattedDesc,
      style: TextStyle(fontSize: 24),
      textAlign: TextAlign.center,
    );
  }

  Widget showIcon(String icon) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/gif/loading.gif',
      image: 'http://$kIconHost/img/wn/$icon@4x.png',
      width: 100,
      height: 100,
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
        final args = ModalRoute.of(context)!.settings.arguments;

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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Text(
                state.weather.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      TimeOfDay.fromDateTime(state.weather.lastUpdated)
                          .format(context),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${args.toString()} (${state.weather.country})',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${state.weather.temp}°C',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              Row(
                children: [
                  Spacer(),
                  showIcon(state.weather.icon),
                  Expanded(flex: 3, child: showDesc(state.weather.description)),
                  Spacer()
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Weather Details',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5, top: 13),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Max Temperature : ',
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      '${state.weather.tempMax}°C',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Min Temperature : ',
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      '${state.weather.tempMin}°C',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Humidity : ',
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      '${state.weather.humidity}',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pressure : ',
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      '${state.weather.pressure}',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
