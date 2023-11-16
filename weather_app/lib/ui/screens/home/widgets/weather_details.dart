import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/constants.dart';
import 'dart:math' as math;

import 'package:weather_app/core/utils/date_time_extension.dart';
import 'package:weather_app/core/view_models/screens/interfaces/iweather_screen_view_model.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IWeatherScreenViewModel>(builder: (context, vm, snapshot) {
      return vm.currentWeather != null
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                height: 180.h,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wind(
                            weather: vm.currentWeather!,
                          ),
                          Sunrise(
                            weather: vm.currentWeather!,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: MainWeather(
                      weather: vm.currentWeather!,
                    ))
                  ],
                ),
              ),
            )
          : Container();
    });
  }
}

class Wind extends StatelessWidget {
  const Wind({super.key, required this.weather});
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87.h,
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: defaultCardStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${degreesToDirection(weather.windDegree)}\n${(weather.windSpeed?.toInt() ?? 0) * 3.6}km/h',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
          ),
          Transform.rotate(
            angle: (weather.windDegree ?? 0) * math.pi / 180,
            child: Icon(
              Icons.arrow_circle_down_sharp,
              size: 50.sp,
            ),
          ),
        ],
      ),
    );
  }
}

String degreesToDirection(double? degrees) {
  if (degrees == null) return '';
  if (degrees >= 0 && degrees < 22.5) {
    return 'North';
  } else if (degrees >= 22.5 && degrees < 67.5) {
    return 'Northeast';
  } else if (degrees >= 67.5 && degrees < 112.5) {
    return 'East';
  } else if (degrees >= 112.5 && degrees < 157.5) {
    return 'Southeast';
  } else if (degrees >= 157.5 && degrees < 202.5) {
    return 'South';
  } else if (degrees >= 202.5 && degrees < 247.5) {
    return 'Southwest';
  } else if (degrees >= 247.5 && degrees < 292.5) {
    return 'West';
  } else if (degrees >= 292.5 && degrees < 337.5) {
    return 'Northwest';
  } else {
    return 'North';
  }
}

class Sunrise extends StatelessWidget {
  const Sunrise({super.key, required this.weather});
  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87.h,
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: defaultCardStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${weather.sunrise.toDateString()} Sun Rise',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
          ),
          Text(
            '${weather.sunset.toDateString()} Sun Set',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}

class MainWeather extends StatelessWidget {
  const MainWeather({super.key, required this.weather});
  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      decoration: defaultCardStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Item(
            title: "Temp",
            value: '${weather.temperature!.celsius!.toInt()}°C',
          ),
          Item(
            title: "Feels Like",
            value: '${weather.tempFeelsLike!.celsius!.toInt()}°C',
          ),
          Item(
            title: "Temp Min",
            value: '${weather.tempMin!.celsius!.toInt()}°C',
          ),
          Item(
            title: "Temp Max",
            value: '${weather.tempMax!.celsius!.toInt()}°C',
          ),
          Item(
            title: "Pressure",
            value: '${weather.pressure!.toInt()}mbar',
          ),
          Item(
            title: "Humidity",
            value: '${weather.humidity!.toInt()}%',
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 6, 8, 6),
      child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.white24),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
              ),
              Text(value),
            ],
          )),
    );
  }
}
