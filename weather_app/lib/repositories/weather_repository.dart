import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherRepository {
  final String apiKey = '336ef8caec0e397d3cc73b5d81af2f81';
  final String city = 'Jakarta';

  Future<Weather> fetchWeather() async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      data['hourly'] = await fetchHourlyWeather(data['coord']['lat'], data['coord']['lon']);
      return Weather.fromJson(data);
    } else {
      print('Failed to fetch weather data: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<List<Map<String, dynamic>>> fetchHourlyWeather(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['list'];
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      print('Failed to fetch hourly weather data: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to fetch hourly weather data');
    }
  }
}
