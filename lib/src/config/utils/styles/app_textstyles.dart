import 'package:flutter/material.dart';

import 'app_fonts.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}

// regular style

TextStyle getRegularStyle(
    {double fontSize = AppFontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, AppFontWeight.regular, color);
}
// light text style

TextStyle getLightStyle(
    {double fontSize = AppFontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, AppFontWeight.light, color);
}
// bold text style

TextStyle getBoldStyle(
    {double fontSize = AppFontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, AppFontWeight.bold, color);
}

// semi bold text style

TextStyle getSemiBoldStyle(
    {double fontSize = AppFontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, AppFontWeight.semiBold, color);
}

// medium text style

TextStyle getMediumStyle(
    {double fontSize = AppFontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, AppFontWeight.medium, color);
}

TextStyle italic = const TextStyle(
  fontSize: 12,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.w100,
);
