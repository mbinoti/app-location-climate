import 'package:appclimatempo/src/features/weather/domain/weather_model.dart';
import 'package:appclimatempo/src/features/weather/presentation/controllers/weather_controller.dart';

import 'package:flutter/material.dart';
import 'package:appclimatempo/src/constants/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final WeatherController weatherController;

  LocationScreen({required this.weatherController});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int? temperature;
  String? weatherIcon;
  String? cityName;
  String? weatherMessage;

  @override
  void initState() {
    super.initState();
    widget.weatherController.fetchLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        await widget.weatherController.fetchLocationWeather();
                      },
                      child: const Icon(Icons.near_me, size: 40.0),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityScreen(),
                          ),
                        );
                        if (typedName != null) {
                          await widget.weatherController
                              .fetchCityWeather(typedName);
                          if (widget
                              .weatherController.value!.weatherIcon.isEmpty) {}
                        }
                      },
                      child: const Icon(Icons.location_city, size: 40.0),
                    ),
                  ],
                ),
                ValueListenableBuilder<WeatherModel?>(
                  valueListenable: widget.weatherController.weatherNotifier,
                  builder: (context, value, child) {
                    if (value == null) {
                      return const Center(
                        child: SpinKitDoubleBounce(
                          color: Colors.white,
                          size: 100.0,
                        ),
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Row(
                              children: <Widget>[
                                Text('${value.temperature}°',
                                    style: kTempTextStyle),
                                Text(value.weatherIcon!,
                                    style: kConditionTextStyle),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Text(
                              '${value.weatherMessage} in ${value.cityName}',
                              textAlign: TextAlign.right,
                              style: kMessageTextStyle,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
