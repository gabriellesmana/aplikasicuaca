class Weather {
  final double temperature;
  final double windSpeed;
  final int humidity;
  final double visibility;
  final List<HourlyWeather> hourlyForecast;

  Weather({
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.visibility,
    required this.hourlyForecast,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    var hourlyForecastJson = json['hourly'] as List;
    List<HourlyWeather> hourlyForecast = hourlyForecastJson.map((i) => HourlyWeather.fromJson(i)).toList();

    return Weather(
      temperature: json['main']['temp'],
      windSpeed: json['wind']['speed'],
      humidity: json['main']['humidity'],
      visibility: json['visibility'].toDouble(),
      hourlyForecast: hourlyForecast,
    );
  }
}

class HourlyWeather {
  final double temperature;
  final String weatherCondition;
  final String time;

  HourlyWeather({
    required this.temperature,
    required this.weatherCondition,
    required this.time,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      temperature: json['main']['temp'],
      weatherCondition: json['weather'][0]['description'],
      time: json['dt_txt'],
    );
  }
}
