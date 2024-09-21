import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/widgets/input_row.dart';
import 'package:weather_app/widgets/current_weather/main_weather_info.dart';
import 'package:weather_app/widgets/current_weather/weather_info.dart';
import 'package:weather_app/widgets/custom_loading_widget.dart';
import 'package:weather_app/widgets/custom_error_widget.dart';
import 'package:weather_app/widgets/weather_forecast/forecast_list.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    context.read<WeatherBloc>().add(FetchWeather());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 9, 86, 145),
              Color.fromARGB(255, 12, 35, 54),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              LayoutBuilder(builder: (context, constraints) {
                double sideMargin;
                if (constraints.maxWidth > 1440) {
                  sideMargin = 150;
                } else if (constraints.maxWidth > 1280) {
                  sideMargin = 100;
                } else if (constraints.maxWidth > 1024) {
                  sideMargin = 80;
                } else if (constraints.maxWidth > 768) {
                  sideMargin = 60;
                } else if (constraints.maxWidth > 600) {
                  sideMargin = 40;
                } else {
                  sideMargin = 1;
                }
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: sideMargin),
                  child: Column(
                    children: [
                      const InputRow(),

                      // BlocBuilder to rebuild UI based on WeatherBloc state
                      BlocBuilder<WeatherBloc, WeatherState>(
                        builder: (context, state) {
                          if (state is WeatherLoading) {
                            return const Expanded(
                              child: CustomLoadingWidget(),
                            );
                          } else if (state is WeatherError) {
                            return Column(
                              children: [
                                const SizedBox(height: 20),
                                CustomErrorWidget(errorMessage: state.error),
                              ],
                            );
                          } else if (state is WeatherLoaded) {
                            return Expanded(
                              child: Column(
                                children: [
                                  MainWeatherInfo(
                                    weather: state.weather,
                                    units: state.units,
                                  ),
                                  const SizedBox(height: 20),
                                  WeatherInfo(
                                    weather: state.weather,
                                    units: state.units,
                                  ),
                                  Expanded(
                                    child: ForecastList(
                                      dailyForecast:
                                          state.weather.dailyForecast,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
