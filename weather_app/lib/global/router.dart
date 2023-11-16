import 'package:flutter/material.dart';

import '../ui/screens/home_screen.dart';

class MyRouter {
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
      case home:
        return _buildRouteNavigationWithoutEffect(
          settings,
          HomeScreen(),
        );

      default:
        return _buildRouteNavigationWithoutEffect(
          settings,
          HomeScreen(),
        );
    }
  }
}
