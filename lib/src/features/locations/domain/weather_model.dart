import 'package:appclimatempo/src/features/locations/data/weather_data.dart';
import 'package:appclimatempo/src/services/location.dart';
import 'package:appclimatempo/src/services/networking.dart';
import 'package:flutter/material.dart';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey = '8608dd13ffbf3f5350e4cc7c0b9ad282';

class WeatherModel {
  final weatherNotifier = ValueNotifier<WeatherData?>(null);

  Future<void> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    // print('$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    updateUI(weatherData);
  }

  Future<void> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
      '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric',
    );

    var weatherData = await networkHelper.getData();
    updateUI(weatherData);
  }

  String getWeatherIcon(int condition) {
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

  String getMessage(int temp) {
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

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      weatherNotifier.value = WeatherData(
        temperature: 0,
        weatherIcon: 'Error',
        weatherMessage: 'Unable to get weather data',
        cityName: '',
      );
    } else {
      double temp = weatherData['main']['temp'];
      int temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      String weatherIcon = getWeatherIcon(condition);
      String weatherMessage = getMessage(temperature);
      String cityName = weatherData['name'];

      weatherNotifier.value = WeatherData(
        temperature: temperature,
        weatherIcon: weatherIcon,
        weatherMessage: weatherMessage,
        cityName: cityName,
      );
    }
  }
}
