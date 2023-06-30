class WeatherState {
  final bool isLoading;
  final dynamic weatherData;
  final String? error;

  WeatherState({this.isLoading = false, this.weatherData, this.error});

  factory WeatherState.loading() => WeatherState(isLoading: true);

  factory WeatherState.loaded(dynamic weatherData) =>
      WeatherState(weatherData: weatherData);

  factory WeatherState.error(String error) => WeatherState(error: error);
}
