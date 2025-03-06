import 'package:flutter/material.dart';
import '../helpers/weather_helper.dart';
import '../models/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final WeatherHelper _weatherHelper = WeatherHelper.weatherHelper;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _weatherHelper.getWeather(city);
      _weather = WeatherModel.fromJson(data);
    } catch (e) {
      _errorMessage = 'Failed to fetch weather data. Please try again.';
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
