import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';

void main() {
  runApp(
      // ---------- Initializing Providers for State Management ----------
      BlocProvider(
    create: (context) => WeatherBloc(
        weatherService: WeatherService(API_KEY),
        locationService: LocationService(API_KEY)),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
