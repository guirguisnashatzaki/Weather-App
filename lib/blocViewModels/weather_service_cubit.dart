import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/constants.dart';
import 'package:weatherapp/models/weatherModel.dart';
import 'package:weatherapp/services/weather_service.dart';

part 'weather_service_state.dart';

class WeatherServiceCubit extends Cubit<WeatherServiceState> {
  final WeatherService _weatherService = const WeatherService(apiKey: constants.API_KEY);
  WeatherServiceCubit() : super(WeatherServiceInitial(null));
  Weather? weather;

  Future<void> fetchWeatherForCurrentLocation()async{
    String cityName = await _weatherService.getCurrentCity();
    try{
      final weather = await _weatherService.getWeather(cityName);
      emit(WeatherLoaded(weather));
    }catch(e){
      emit(WeatherError(null));
    }
  }

  fetchWeatherForDesiredCity(String cityName) async {
    try{
      final weather = await _weatherService.getWeather(cityName);
      emit(WeatherLoaded(weather));
    }catch(e){
      emit(WeatherError(null));
    }
  }

  clearWeather(){
    emit(WeatherServiceInitial(null));
  }
}
