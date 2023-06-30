import 'package:appclimatempo/src/constants/constants.dart';
import 'package:appclimatempo/src/features/weather/domain/weather_model.dart';
import 'package:appclimatempo/src/location/location.dart';
import 'package:appclimatempo/src/location/networking.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WeatherController extends ValueNotifier<WeatherModel?> {
  WeatherController(WeatherModel? value) : super(value);

  ValueListenable<WeatherModel?> get weatherNotifier => this;

  Future<void> fetchCityWeather(String cityName) async {
    var weatherData = await _getCityWeather(cityName);
    if (weatherData != null) {
      value = WeatherModel(
        temperature: weatherData['main']['temp'].toInt(),
        weatherIcon: _getWeatherIcon(weatherData['weather'][0]['id']),
        weatherMessage: _getMessage(weatherData['main']['temp'].toInt()),
        cityName: weatherData['name'],
      );
    } else {
      value = WeatherModel(
        temperature: 0,
        weatherIcon: 'Error',
        weatherMessage: 'Unable to get weather data',
        cityName: '',
      );
    }
  }

  Future<void> fetchLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
      '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
    );

    var weatherData = await networkHelper.getData();
    if (weatherData != null) {
      value = WeatherModel(
        temperature: weatherData['main']['temp'].toInt(),
        weatherIcon: _getWeatherIcon(weatherData['weather'][0]['id']),
        weatherMessage: _getMessage(weatherData['main']['temp'].toInt()),
        cityName: weatherData['name'],
      );
    } else {
      value = WeatherModel(
        temperature: 0,
        weatherIcon: 'Error',
        weatherMessage: 'Unable to get weather data',
        cityName: '',
      );
    }
  }

  // Future<void> getLocationWeather() async {
  //   Location location = Location();
  //   await location.getCurrentLocation();

  //   NetworkHelper networkHelper = NetworkHelper(
  //     '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
  //   );

  //   var weatherData = await networkHelper.getData();
  //   // updateUI(weatherData);
  // }

  Future<dynamic> _getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    // var weatherData = await networkHelper.getData();
    return await networkHelper.getData();
    // updateUI(weatherData);
  }

  String _getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String _getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
