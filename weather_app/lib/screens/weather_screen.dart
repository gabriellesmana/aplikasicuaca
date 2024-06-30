import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherCubit = context.read<WeatherCubit>();

    weatherCubit.fetchWeather();

    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: SafeArea(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {
              return WeatherView(weather: state.weather);
            } else if (state is WeatherError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('Mohon tunggu...'));
          },
        ),
      ),
    );
  }
}

class WeatherView extends StatelessWidget {
  final Weather weather;

  const WeatherView({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade300, Colors.blue.shade900],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jakarta, Indonesia',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${weather.temperature.toInt()}°',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          '${weather.hourlyForecast[0].weatherCondition}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        SizedBox(
                            height:
                                115.0), // Atur tinggi sesuai kebutuhan untuk menggeser konten
                        Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                                0.3), // Warna latar belakang dengan transparansi
                            borderRadius: BorderRadius.circular(
                                16.0), // Radius sudut kotak
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _getWeatherIcon(
                                    weather.hourlyForecast[0].weatherCondition),
                                color: Colors.white,
                                size: 50,
                              ),
                              SizedBox(width: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Angin: ${weather.windSpeed} km/h',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Kelembaban: ${weather.humidity}%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Visibilitas: ${weather.visibility} km',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16.0),
                      Text(
                        '7 Hari ke Depan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              weather.hourlyForecast.length,
                              (index) {
                                final hour = weather.hourlyForecast[index];
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: SizedBox(
                                      width: 150, // Atur lebar sesuai kebutuhan
                                      child: Column(
                                        mainAxisSize: MainAxisSize
                                            .min, // Gunakan MainAxisSize.min
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${hour.temperature.toInt()}°',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 8.0),
                                          Icon(
                                            _getWeatherIcon(
                                                hour.weatherCondition),
                                            color: Colors.blue,
                                            size: 50,
                                          ),
                                          SizedBox(height: 8.0),
                                          Text(
                                            hour.time
                                                .split(' ')[1]
                                                .substring(0, 5),
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    print('Condition: $condition'); // Tambahkan print statement ini
    switch (condition.toLowerCase()) {
      case 'cerah':
        return Icons.wb_sunny;
      case 'sedikit awan':
      case 'awan tersebar':
      case 'awan pecah':
        return Icons.wb_cloudy;
      case 'hujan deras':
      case 'hujan':
        return Icons.grain;
      case 'badai petir':
        return Icons.flash_on;
      case 'salju':
        return Icons.ac_unit;
      case 'kabut':
        return Icons.blur_on;
      case 'overcast': // Tambahkan kasus ini
        return Icons.wb_cloudy;
      default:
        return Icons.wb_cloudy;
    }
  }
}
