import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WeatherHourCard(
                  time: '13:00',
                  icon: Icons.wb_sunny,
                  temperature: 26,
                ),
                WeatherHourCard(
                  time: '14:00',
                  icon: Icons.thunderstorm,
                  temperature: 26,
                ),
                WeatherHourCard(
                  time: '15:00',
                  icon: Icons.wb_cloudy,
                  temperature: 23,
                ),
                WeatherHourCard(
                  time: '16:00',
                  icon: Icons.wb_sunny,
                  temperature: 27,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Next 7 Days', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}

class WeatherHourCard extends StatelessWidget {
  final String time;
  final IconData icon;
  final int temperature;

  WeatherHourCard({
    required this.time,
    required this.icon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(time),
        Icon(icon),
        Text('$temperature°'),
      ],
    );
  }
}
