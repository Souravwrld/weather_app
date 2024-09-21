import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants.dart';

class LocationService {
  final String apiKey;

  LocationService(this.apiKey);

  // ---------- Get Current Position ----------
  // Reference: https://pub.dev/packages/geolocator
  Future<Position> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    // Define location settings
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );

    // Fetch the current location
    Position position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    return position;
  }

  // ---------- Get City Name by Coordinates ----------
  Future<String> getCityNameByCoordinates(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('${GEO_BASE_URL}reverse?lat=$lat&lon=$lon&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return data[0]['name'];
      } else {
        throw Exception('City not found!');
      }
    } else {
      throw Exception('Failed to load city name.');
    }
  }

  // ---------- Get Coordinates by City Name ----------
  Future<Map<String, double>> getCoordinatesByCityName(String cityName) async {
    final response = await http.get(
      Uri.parse('${GEO_BASE_URL}direct?q=$cityName&limit=1&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return {'lat': data[0]['lat'], 'lon': data[0]['lon']};
      } else {
        throw Exception('Coordinates not found!');
      }
    } else {
      throw Exception('Failed to load coordinates.');
    }
  }
}
