import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/core/utils/string_extension.dart';
import '../interfaces/iweather_screen_view_model.dart';

class WeatherScreenViewModel extends ChangeNotifier
    implements IWeatherScreenViewModel {
  List<Weather> _weatherList = [];
  WeatherFactory ws = WeatherFactory('9ea27713c827a6882b01aa797c0a694e');
  @override
  List<Weather> get weatherList => _weatherList;

  Weather? _currentWeather;
  @override
  Weather? get currentWeather => _currentWeather;

  @override
  Future<bool> updateLocation(String cityName) async {
    EasyLoading.show();
    try {
      _currentWeather = await ws.currentWeatherByCityName(cityName);

      await getWeatherList(cityName: cityName);
      EasyLoading.dismiss();
      notifyListeners();
      return true;
    } on Exception catch (e) {
      EasyLoading.showError('ERROR');
      return false;
    }
  }

  @override
  Future<void> init() async {
    Position position = await determinePosition() ??
        Position(
          latitude: 10.7769,
          longitude: 106.7009,
          timestamp: DateTime.now(),
          accuracy: 5.0,
          altitude: 50.0,
          altitudeAccuracy: 2.0,
          heading: 90.0,
          headingAccuracy: 1.5,
          speed: 20.0,
          speedAccuracy: 1.0,
        ); // mock position HCM
    try {
      _currentWeather = await ws.currentWeatherByLocation(
          position.latitude, position.longitude);
      await getWeatherList(position: position);
      EasyLoading.dismiss();
      notifyListeners();
    } on Exception catch (e) {
      EasyLoading.showError('ERROR');
    }
  }

  Future<void> getWeatherList(
      {Position? position, String cityName = ''}) async {
    try {
      if (cityName != '') {
        _weatherList = await ws.fiveDayForecastByCityName(cityName);
      } else {
        _weatherList = await ws.fiveDayForecastByLocation(
            position!.latitude, position.longitude);
      }
    } on Exception catch (e) {}
  }

  Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return null;
      }
    } else {}
    return await Geolocator.getCurrentPosition();
  }
}
