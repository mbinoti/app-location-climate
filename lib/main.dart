import 'package:appclimatempo/src/features/weather/presentation/widgets/location_screen.dart';
import 'package:flutter/material.dart';

import 'src/features/weather/presentation/controllers/weather_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Create an instance of WeatherController.
  final weatherController = WeatherController(null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LocationScreen(
        weatherController: weatherController,
      ),
    );
  }
}
