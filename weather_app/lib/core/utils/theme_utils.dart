import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_utils.dart';

class ThemeUtils {
  static final lightTheme = ThemeData(
    dialogBackgroundColor: Colors.white,
    brightness: Brightness.light,
    primaryTextTheme: Typography().white,
    textTheme: Typography().white,
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
