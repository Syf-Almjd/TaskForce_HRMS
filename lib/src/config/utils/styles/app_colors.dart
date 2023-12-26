import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColor = Color(0x993665FF); //0xff4e4edd
  static const Color lowPriority = Color(0xffb8a4ff);

  static const Color secondaryColor = Color(0xff3e34af);
  static const Color darkColor = Color(0xff000036);
  static const Color scaffoldColor = Color(0x996889F5);
  static const Color appBarColor = Color(0xff2e2eff);
  static const Color primaryLight = Color(0xffc5d1ff);
  static const Color greenColor = Color(0xf461df25);
  static const Color redColor = Color(0xf4df2535);
  static const Color white = Color(0xffffffff);
  static const Color grey = Color(0xffF5F5F5);
  static const Color greyDark = Color(0xff7a7a7a);
  static const Color blackLight = Color(0xff3a3a3a);
  static const Color blackDark = Color(0xff000000);
}

extension GetHexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
