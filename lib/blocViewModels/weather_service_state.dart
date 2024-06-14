part of 'weather_service_cubit.dart';

@immutable
abstract class WeatherServiceState extends Equatable{}

class WeatherServiceInitial extends WeatherServiceState {
  Weather? weather;

  WeatherServiceInitial(this.weather);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherLoaded extends WeatherServiceState{
  Weather? weather;

  WeatherLoaded(this.weather);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherError extends WeatherServiceState{
  Weather? weather;

  WeatherError(this.weather);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
