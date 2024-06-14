import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/blocViewModels/loading_cubit.dart';
import 'package:weatherapp/blocViewModels/weather_service_cubit.dart';
import 'package:weatherapp/pages/weather_page.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => WeatherServiceCubit(const WeatherService(apiKey: constants.API_KEY)),
          ),
          BlocProvider(
            create: (BuildContext context) => LoadingCubit(),
          ),
        ],
        child: const WeatherPage(),
      ),
    );
  }
}

