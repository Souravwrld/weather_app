import 'package:flutter/material.dart';

class ForecastItem extends StatelessWidget {
  final String date;
  final String minTemperature;
  final String maxTemperature;
  final IconData weatherIcon;

  const ForecastItem({
    super.key,
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.weatherIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ---------- Date ----------
          Container(
            width: 90,
            alignment: Alignment.centerLeft,
            child: Text(
              date,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),

          // ---------- Weather Icon ----------
          Icon(weatherIcon, size: 24, color: Colors.white),

          // ---------- Min/Max Temperature ----------
          Row(
            children: [
              Text(
                minTemperature,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const Text(
                ' / ',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                maxTemperature,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
