import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/blocViewModels/loading_cubit.dart';
import 'package:weatherapp/blocViewModels/weather_service_cubit.dart';
import 'package:weatherapp/models/weatherModel.dart';
import 'package:weatherapp/widgets/MyButton.dart';
import 'package:weatherapp/widgets/myCustomTextFormField.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  TextEditingController controller = TextEditingController();

  String getWeatherCondition(String? mainCondition){
      if(mainCondition == null) return "assets/Sunny.json";

      switch (mainCondition.toLowerCase()){
        case 'clear':
          return "assets/Sunny.json";
        case 'fog':
          return "assets/Cloud.json";
        case 'mist':
          return "assets/Cloud.json";
        case 'clouds':
          return "assets/Cloud.json";
        case 'shower rain':
          return "assets/Rainy.json";
        case 'rain':
          return "assets/Rainy.json";
        default:
          return "assets/Sunny.json";
      }
  }

  showMyDialog(String message){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: message ,
      btnOkOnPress: () {},
    ).show();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (BuildContext context,ConnectivityResult connectivity,Widget child){
        final bool connected = connectivity != ConnectivityResult.none;

        if(connected){
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<WeatherServiceCubit,WeatherServiceState>(
                      builder: (BuildContext context, WeatherServiceState state) {
                        Weather? myWeather;
                        if(state is WeatherLoaded){
                          myWeather = (state).weather;
                          Future.delayed(
                            Duration.zero,
                                () {
                              BlocProvider.of<LoadingCubit>(context).setIsLoading(false);
                            },
                          );
                        }else if(state is WeatherError){
                          myWeather = null;
                          Future.delayed(
                            Duration.zero,
                            () {
                              BlocProvider.of<LoadingCubit>(context).setIsLoading(false);
                              showMyDialog('Couldn\'t get this city');
                            },
                          );
                        }else if(state is WeatherServiceInitial){
                          myWeather = null;
                        }

                        return Column(
                          children: [
                            myWeather?.cityName == null? const SizedBox.shrink() :SizedBox(height: MediaQuery.of(context).size.height/20,),
                            Text(myWeather?.cityName ?? "",
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            BlocBuilder<LoadingCubit,LoadingState>(
                              builder: (BuildContext context, LoadingState state) {
                                if(state is Loading){
                                  return Lottie.asset("assets/loading.json");
                                }else{
                                  return Lottie.asset(myWeather?.cityName == null? "assets/start.json":getWeatherCondition(myWeather?.mainCondition));
                                }
                              },
                            ),
                            myWeather?.cityName == null? const SizedBox.shrink() :const SizedBox(height: 20,),
                            Text(myWeather?.temperature == null ? "":'${myWeather?.temperature?.round()} °C',
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(myWeather?.mainCondition ?? "",
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );

                      },
                    ),
                    Column(
                      children: [
                        myCustomTextFormField(controller: controller,),
                        myButton(text: "Get Weather of Your Location", fun: ()async{
                          controller.clear();
                          final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
                          if (connectivityResult.name == "none") {
                            return;
                          }
                          Future.delayed(
                            const Duration(milliseconds: 0),
                                () => BlocProvider.of<LoadingCubit>(context).setIsLoading(true),
                          );
                          Future.delayed(
                            const Duration(milliseconds: 0),
                                () => BlocProvider.of<WeatherServiceCubit>(context).clearWeather(),
                          );

                          Future.delayed(
                            const Duration(milliseconds: 0),
                                () => BlocProvider.of<WeatherServiceCubit>(context).fetchWeatherForCurrentLocation().then((value){
                              Future.delayed(
                                const Duration(milliseconds: 0),
                                    () => BlocProvider.of<LoadingCubit>(context).setIsLoading(false),
                              );
                            }),
                          );
                        }),
                        myButton(text: "Get Weather of the desired city", fun: () async {
                          final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
                          if (connectivityResult.name == "none") {
                            return;
                          }
                          Future.delayed(
                            const Duration(milliseconds: 0),
                                () => BlocProvider.of<LoadingCubit>(context).setIsLoading(true),
                          );
                          Future.delayed(
                            const Duration(milliseconds: 0),
                                () => BlocProvider.of<WeatherServiceCubit>(context).clearWeather(),
                          );
                          if(controller.text.toString().isEmpty){
                            showMyDialog('Put a city name');
                            Future.delayed(
                              const Duration(milliseconds: 0),
                                  () => BlocProvider.of<LoadingCubit>(context).setIsLoading(false),
                            );
                          }else{
                            Future.delayed(
                              const Duration(milliseconds: 0),
                                  () => BlocProvider.of<WeatherServiceCubit>(context).fetchWeatherForDesiredCity(controller.text.toString()),
                            );
                          }
                        },),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }else{
          return  Center(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Can\'t connect .. check internet',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey,
                      decoration: TextDecoration.none
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset('assets/no_internet.png')
                ],
              ),
            ),
          );
        }
      },
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}