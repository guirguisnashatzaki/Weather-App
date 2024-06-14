import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weatherModel.dart';
import '../constants.dart';

class WeatherService{
  final String apiKey;

  const WeatherService({
    required this.apiKey,
  });

  Future<Weather> getWeather(String cityName) async {
    Dio dio = Dio();
    final response = await dio.get("${constants.BASE_URL}?q=$cityName&appid=$apiKey&units=metric");

    if(response.statusCode == 200){
      Weather weather = Weather(
        cityName: response.data['name'] ,
        mainCondition: response.data['weather'][0]['main'],
        temperature: response.data['main']['temp']
      );
      return weather;
    }else{
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placeMarks[0].administrativeArea;

    return city ?? "";
  }
}