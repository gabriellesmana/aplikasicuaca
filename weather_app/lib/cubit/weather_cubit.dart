import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherRepository) : super(WeatherInitial());

  final WeatherRepository weatherRepository;

  void fetchWeather() async {
    try {
      emit(WeatherLoading());
      final weather = await weatherRepository.fetchWeather();
      emit(WeatherLoaded(weather));
    } catch (e) {
      print('Error: $e');
      emit(WeatherError('Failed to fetch weather data'));
    }
  }
}
