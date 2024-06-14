import 'package:equatable/equatable.dart';

class Weather extends Equatable{
  String? cityName;
  double? temperature;
  String? mainCondition;

  Weather({this.cityName, this.temperature, this.mainCondition});

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json['cityName'];
    temperature = json['temperature'];
    mainCondition = json['mainCondition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cityName'] = cityName;
    data['temperature'] = temperature;
    data['mainCondition'] = mainCondition;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}