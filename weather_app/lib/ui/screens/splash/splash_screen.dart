import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/global/router.dart';

import '../../../core/view_models/screens/interfaces/iweather_screen_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late IWeatherScreenViewModel iWeatherScreenViewModel;
  @override
  void initState() {
    super.initState();
    iWeatherScreenViewModel = context.read<IWeatherScreenViewModel>();
    Future.delayed(Duration.zero, () async {
      await iWeatherScreenViewModel.init();
      Get.toNamed(MyRouter.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.8, -0.6),
          colors: [Colors.yellow, Colors.lightBlue],
          radius: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png'),
          Text(
            'WEATHER\nAPPLICATION',
            style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
