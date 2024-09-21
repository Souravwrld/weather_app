import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/daily_forecast_model.dart';
import 'forecast_list_item.dart';

class ForecastList extends StatelessWidget {
  final List<DailyForecast> dailyForecast;

  const ForecastList({super.key, required this.dailyForecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 10, 79, 132),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------- Sticky Header ----------
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white24, width: 1),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_month_outlined,
                    color: Colors.white.withOpacity(0.6), size: 18),
                const SizedBox(width: 5),
                const Text(
                  '5 Day Forecast',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),

          // ---------- Forecast List ----------
          Expanded(
            child: ListView.builder(
              itemCount: dailyForecast.length > 6
                  ? 6
                  : dailyForecast.length, // limit to today + 5 days
              itemBuilder: (context, index) {
                final daily = dailyForecast[index];
                return ForecastItem(
                  date: index == 0
                      ? 'Today'
                      : DateFormat('EEEE').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              daily.date * 1000)),
                  minTemperature: '${daily.minTemp.round()}°',
                  maxTemperature: '${daily.maxTemp.round()}°',
                  weatherIcon: _getWeatherIcon(daily.mainCondition),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String mainCondition) {
    switch (mainCondition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.wb_cloudy;
      case 'rain':
        return Icons.grain;
      case 'snow':
        return Icons.ac_unit;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'drizzle':
        return Icons.grain;
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
      case 'squall':
      case 'tornado':
        return Icons.dehaze;
      default:
        return Icons.wb_sunny; // Default to a sunny icon
    }
  }
}
