import 'package:flutter/material.dart';

abstract class AppColors {
  static Color white = const Color(0xffffffff);
  static Color grey = const Color(0xffF5F5F5);
  static Color greyDark = const Color(0xff898989);

  static Color lowPriority = const Color(0xff848191);
  static Color primaryColor = const Color(0x9936E2FF); //0xff4e4edd
  static Color secondaryColor = const Color(0xff282162);
  static Color darkColor = const Color(0xff000036);
  static Color scaffoldColor = const Color(0xff1A1A29);
  static Color appBarColor = const Color(0xff9999d4);
  static Color primaryLight = const Color(0xff31313F);
  static Color greenColor = const Color(0xf461df25);
  static Color redColor = const Color(0xf4df2535);
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
