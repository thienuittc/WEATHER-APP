import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/screens/widgets/background.dart';
import 'package:weather_app/ui/screens/widgets/weather_details.dart';

import '../../core/view_models/screens/interfaces/iweather_screen_view_model.dart';
import 'widgets/enter_city_dialog.dart';
import 'widgets/weather_timeline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IWeatherScreenViewModel iWeatherScreenViewModel;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    iWeatherScreenViewModel = context.read<IWeatherScreenViewModel>();
    Future.delayed(Duration.zero, () async {
      await iWeatherScreenViewModel.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          const BackGround(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Consumer<IWeatherScreenViewModel>(builder: (_, vm, __) {
                      if (vm.currentWeather != null) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => Get.dialog(EnterCityDialog(
                                controller: controller,
                                onSubmit: () async {
                                  if (await vm
                                      .updateLocation(controller.text)) {
                                    Get.back();
                                  }
                                  ;
                                },
                              )),
                              child: Text(
                                '${vm.currentWeather?.areaName ?? ''}✍️',
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${vm.currentWeather?.temperature?.celsius?.toInt()}',
                                    style: TextStyle(
                                      fontSize: 80.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: Offset(2, -30.sp),
                                      child: Text(
                                        '°C',
                                        style: TextStyle(
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.network(
                                'https://openweathermap.org/img/wn/${vm.currentWeather!.weatherIcon}@2x.png'),
                          ],
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                    SizedBox(
                      height: 20.h,
                    ),
                    const WeatherTimeline(),
                    const WeatherDetails()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
