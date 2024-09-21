import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;
  final LocationService locationService;

  String _units = 'metric';

  WeatherBloc({required this.weatherService, required this.locationService})
      : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());

      try {
        double lat;
        double lon;

        // Get coordinates based on city name if provided
        if (event.cityName != null && event.cityName!.isNotEmpty) {
          final coordinates =
              await locationService.getCoordinatesByCityName(event.cityName!);
          lat = coordinates['lat']!;
          lon = coordinates['lon']!;
        } else {
          // Get coordinates based on current location
          final position = await locationService.getCurrentPosition();
          lat = position.latitude;
          lon = position.longitude;
        }

        final weather =
            await weatherService.getWeatherByCoordinates(lat, lon, _units);
        emit(WeatherLoaded(weather: weather, units: _units));
      } catch (e) {
        emit(WeatherError('Failed to load weather data. Please try again.'));
      }
    });

    on<SetUnits>((event, emit) {
      _units = event.units;
      if (state is WeatherLoaded) {
        final currentState = state as WeatherLoaded;
        emit(WeatherLoaded(weather: currentState.weather, units: _units));
      }
    });
  }
}
