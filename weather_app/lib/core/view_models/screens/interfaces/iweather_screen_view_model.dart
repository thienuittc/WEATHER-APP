import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

abstract class IWeatherScreenViewModel implements ChangeNotifier {
  List<Weather> get weatherList;
  Weather? get currentWeather;
  Future<bool> updateLocation(String cityName);
  Future<void> init();
}
