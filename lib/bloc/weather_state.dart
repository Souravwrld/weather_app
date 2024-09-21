part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  final String units;

  WeatherLoaded({required this.weather, required this.units});
}

class WeatherError extends WeatherState {
  final String error;

  WeatherError(this.error);
}
