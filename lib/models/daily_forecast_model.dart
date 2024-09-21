class DailyForecast {
  final int date;
  final double minTemp;
  final double maxTemp;
  final String mainCondition;
  final String description;
  // additional information
  final double pop;
  final int sunrise;
  final int sunset;
  final double uvIndex;
  final double humidity;
  final double windSpeed;
  final int windDirection;
  final double pressure;

  DailyForecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.mainCondition,
    required this.description,
    this.pop = 0.0,
    required this.sunrise,
    required this.sunset,
    required this.uvIndex,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.pressure,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: json['dt'],
      minTemp: json['temp']['min'].toDouble(),
      maxTemp: json['temp']['max'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      pop: json['pop'].toDouble(),
      sunrise: json['sunrise'].toInt(),
      sunset: json['sunset'].toInt(),
      uvIndex: json['uvi'].toDouble(),
      humidity: json['humidity'].toDouble(),
      windSpeed: json['wind_speed'].toDouble(),
      windDirection: json['wind_deg'].toInt(),
      pressure: json['pressure'].toDouble(),
    );
  }
}
