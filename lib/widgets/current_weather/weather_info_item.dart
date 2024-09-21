import 'package:flutter/material.dart';

class WeatherInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;

  const WeatherInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ---------- Weather Info Icon ----------
        Icon(icon, color: Colors.white, size: 26),

        // ---------- Label Text (eg. Sunrise, Sunset) ----------
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 9),
        ),

        const SizedBox(height: 4),

        // ---------- Value and Unit Text ----------
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.white, fontSize: 14),
            children: [
              TextSpan(text: value),
              TextSpan(
                text: unit,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
