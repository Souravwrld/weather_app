part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final String? cityName;

  FetchWeather({this.cityName});
}

class SetUnits extends WeatherEvent {
  final String units;

  SetUnits(this.units);
}
