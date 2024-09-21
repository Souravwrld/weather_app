import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/constants.dart';

class WeatherService {
  final String apiKey;

  final LocationService locationService;

  WeatherService(this.apiKey) : locationService = LocationService(apiKey);
  /*
  Constructor Parameter Initialization and Initializer List:
  Reference:
  https://stackoverflow.com/questions/52013357/what-is-the-difference-between-constructor-and-initializer-list-in-dart 
  */

  Future<Weather> getWeatherByCoordinates(
      double lat, double lon, String units) async {
    // fetching weather data
    final response = await http.get(Uri.parse(
        '$BASE_URL?lat=$lat&lon=$lon&exclude=minutely,hourly&units=$units&appid=$apiKey'));

    if (response.statusCode == 200) {
      // fetching city name from coordinates
      final cityName = await locationService.getCityNameByCoordinates(lat, lon);
      return Weather.fromJson(jsonDecode(response.body), cityName);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
