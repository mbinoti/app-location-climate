// import 'package:appclimatempo/src/features/weather/domain/weather_model.dart';
import 'package:appclimatempo/src/features/weather/presentation/controllers/weather_controller.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  // final WeatherModel weatherModel = WeatherModel();
  final WeatherController weatherController;

  LoadingScreen({required this.weatherController});

  // void getLocation() async {
  //   var data = await weatherModel.getLocationWeather();

  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return LocationScreen(locationWeather: data);
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
