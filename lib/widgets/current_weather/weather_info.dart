import 'package:weather_app/models/weather_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/utils/custom_date_utils.dart';
import 'weather_info_item.dart';

class WeatherInfo extends StatelessWidget {
  final Weather weather;
  final String units;

  const WeatherInfo({super.key, required this.weather, required this.units});

  @override
  Widget build(BuildContext context) {
    // Convert pressure from hPa to inHg
    final double pressureInHg = weather.pressure * 0.02953;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 10, 79, 132),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // ---------- Sunrise Information ----------
          WeatherInfoItem(
            icon: CupertinoIcons.sunrise,
            label: 'Sunrise',
            value: CustomDateUtils.formatTime(
                DateTime.fromMillisecondsSinceEpoch(weather.sunrise * 1000)),
            unit: CustomDateUtils.formatPeriod(
                    DateTime.fromMillisecondsSinceEpoch(weather.sunrise * 1000))
                .toLowerCase(),
          ),

          // ---------- Sunset Information ----------
          WeatherInfoItem(
            icon: CupertinoIcons.sunset,
            label: 'Sunset',
            value: CustomDateUtils.formatTime(
                DateTime.fromMillisecondsSinceEpoch(weather.sunset * 1000)),
            unit: CustomDateUtils.formatPeriod(
                    DateTime.fromMillisecondsSinceEpoch(weather.sunset * 1000))
                .toLowerCase(),
          ),

          // ---------- Humidity Information ----------
          WeatherInfoItem(
            icon: CupertinoIcons.drop,
            label: 'Humidity',
            value: '${weather.humidity}',
            unit: '%',
          ),

          // ---------- Wind Speed Information ----------
          WeatherInfoItem(
            icon: CupertinoIcons.wind,
            label: 'Wind',
            value: '${weather.windSpeed}',
            unit: units == 'metric' ? 'm/s' : 'mph',
          ),

          // ---------- Pressure Information ----------
          WeatherInfoItem(
            icon: CupertinoIcons.gauge,
            label: 'Pressure',
            value: pressureInHg.toStringAsFixed(2),
            unit: 'inHg',
          ),
        ],
      ),
    );
  }
}
