import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/view_models/screens/interfaces/iweather_screen_view_model.dart';

class BackGround extends StatelessWidget {
  const BackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(-0.8, -0.6),
              colors: [Colors.yellow, Colors.lightBlue],
              radius: 1.0,
            ),
          ),
        ),
        Consumer<IWeatherScreenViewModel>(builder: (context, vm, snapshot) {
          if (vm.currentWeather != null) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black
                  .withOpacity((vm.currentWeather!.date!.hour - 12).abs() / 12),
            );
          } else {
            return const SizedBox();
          }
        }),
      ],
    );
  }
}
