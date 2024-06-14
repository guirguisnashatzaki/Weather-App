import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weatherapp/blocViewModels/weather_service_cubit.dart';
import 'package:weatherapp/models/weatherModel.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'bloc_test.mocks.dart';

@GenerateMocks([WeatherService])
void main(){
  MockWeatherService weatherService = MockWeatherService();

  group("Bloc test", () {

    var weather = Weather();

    when(weatherService.getWeather("Alexandria")).thenAnswer((realInvocation) => Future.value(weather));

    blocTest<WeatherServiceCubit,WeatherServiceState>(
        "Weather cubit test",
        build: () => WeatherServiceCubit(),
        act: (bloc){
          bloc.fetchWeatherForDesiredCity("Alexandria");
        },
        expect: () => <WeatherServiceState>[

        ]
    );

  });
}