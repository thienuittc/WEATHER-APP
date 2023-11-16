import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/utils/date_time_extension.dart';
import 'package:weather_app/core/view_models/screens/interfaces/iweather_screen_view_model.dart';

import '../../../../constants.dart';

class TemperatureData {
  final String time;
  final double temperature;

  TemperatureData({required this.time, required this.temperature});
}

class WeatherTimeline extends StatelessWidget {
  const WeatherTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: defaultCardStyle,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.timer),
                Text('Weather Forecast for the Next 5 Days'),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Consumer<IWeatherScreenViewModel>(builder: (_, vm, __) {
                return Row(
                  children: vm.weatherList
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 130.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('${e.temperature!.celsius!.toInt()}°C'),
                                  const SizedBox(height: 8),
                                  Container(
                                    height:
                                        e.temperature?.celsius?.toInt().h ?? 0,
                                    width: 10.w,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  Image.network(
                                    'https://openweathermap.org/img/wn/${e.weatherIcon}.png',
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            SizedBox.shrink(),
                                  ),
                                  Text(e.date.toDateString()),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
