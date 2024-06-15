import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
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

  group("Weather Bloc test", () {

    var weather = Weather();

    when(weatherService.getWeather("Alexandria")).thenAnswer((realInvocation) => Future.value(weather));
    when(weatherService.getCurrentCity()).thenAnswer((realInvocation) => Future.value("Alexandria"));

    blocTest<WeatherServiceCubit,WeatherServiceState>(
        "Weather desired city",
        build: () => WeatherServiceCubit(weatherService),
        act: (bloc){
          bloc.fetchWeatherForDesiredCity("Alexandria");
        },
        expect: () => <WeatherServiceState>[
          WeatherLoaded(weather)
        ]
    );

    blocTest<WeatherServiceCubit,WeatherServiceState>(
        "Weather desired city Error",
        build: () => WeatherServiceCubit(weatherService),
        act: (bloc){
          bloc.fetchWeatherForDesiredCity("");
        },
        expect: () => <WeatherServiceState>[
          WeatherError(null)
        ]
    );

    blocTest<WeatherServiceCubit,WeatherServiceState>(
        "Weather my city",
        build: () => WeatherServiceCubit(weatherService),
        act: (bloc){
          bloc.fetchWeatherForCurrentLocation();
        },
        expect: () => <WeatherServiceState>[
          WeatherLoaded(weather)
        ]
    );

    blocTest<WeatherServiceCubit,WeatherServiceState>(
        "Weather clear",
        build: () => WeatherServiceCubit(weatherService),
        act: (bloc){
          bloc.clearWeather();
        },
        expect: () => <WeatherServiceState>[
          WeatherServiceInitial(null)
        ]
    );

  });
}