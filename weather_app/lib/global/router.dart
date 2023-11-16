import 'package:flutter/material.dart';
import 'package:weather_app/ui/screens/splash/splash_screen.dart';

import '../ui/screens/home/home_screen.dart';

class MyRouter {
  static const String splash = '/splash';
  static const String home = '/home';
  static PageRouteBuilder _buildRouteNavigationWithoutEffect(
      RouteSettings settings, Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => widget,
      transitionDuration: Duration.zero,
      settings: settings,
    );
  }

  static PageRouteBuilder _buildRouteNavigation(
      RouteSettings settings, Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => widget,
      settings: settings,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const SplashScreen(),
        );
      case home:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const HomeScreen(),
        );

      default:
        return _buildRouteNavigationWithoutEffect(
          settings,
          const SplashScreen(),
        );
    }
  }
}
