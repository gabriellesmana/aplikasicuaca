import 'package:flutter/material.dart';

class WeatherDetail extends StatelessWidget {
  final double windSpeed;
  final double humidity;
  final double visibility;

  WeatherDetail({
    required this.windSpeed,
    required this.humidity,
    required this.visibility,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(Icons.air, color: Colors.white),
            Text('$windSpeed km/h', style: TextStyle(color: Colors.white)),
            Text('Wind', style: TextStyle(color: Colors.white)),
          ],
        ),
        Column(
          children: [
            Icon(Icons.opacity, color: Colors.white),
            Text('$humidity%', style: TextStyle(color: Colors.white)),
            Text('Humidity', style: TextStyle(color: Colors.white)),
          ],
        ),
        Column(
          children: [
            Icon(Icons.visibility, color: Colors.white),
            Text('$visibility km', style: TextStyle(color: Colors.white)),
            Text('Visibility', style: TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }
}
