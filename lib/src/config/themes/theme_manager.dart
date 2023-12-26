import 'package:flutter/material.dart';

import '../utils/managers/app_constants.dart';
import '../utils/managers/app_values.dart';
import '../utils/styles/app_colors.dart';
import '../utils/styles/app_fonts.dart';
import '../utils/styles/app_textstyles.dart';

ThemeData getApplicationTheme() {
  return ThemeData.light().copyWith(
    colorScheme:
        const ColorScheme.light().copyWith(primary: AppColors.primaryColor),

    //App Transition
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),

    // // main colors of the app
    primaryColor: AppColors.primaryColor,
    shadowColor: AppColors.lowPriority,
    primaryColorDark: AppColors.darkColor,
    disabledColor: AppColors.grey,
    scaffoldBackgroundColor: AppColors.white,
    //Text Theme
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: AppConstants.appFontFamily,
        ),
    primaryTextTheme: ThemeData.light().textTheme.apply(
          fontFamily: AppConstants.appFontFamily,
        ),

    // // ripple color
    // splashColor: AppColors.primaryColor,
    // // will be used incase of disabled button for example
    // hintColor: AppColors.grey,
    // // card view theme
    // cardTheme: CardTheme(
    //     color: AppColors.white,
    //     shadowColor: AppColors.grey,
    //     elevation: AppSize.s4),
    // // App bar theme
    // appBarTheme: AppBarTheme(
    //     centerTitle: true,
    //     color: AppColors.primaryColor,
    //     elevation: AppSize.s4,
    //     shadowColor: AppColors.lowPriority,
    //     titleTextStyle: getRegularStyle(
    //         color: AppColors.white, fontSize: AppFontSize.s16)),
    // // Button theme
    // buttonTheme: ButtonThemeData(
    //     shape: const StadiumBorder(),
    //     disabledColor: AppColors.greyDark,
    //     buttonColor: AppColors.primaryColor,
    //     splashColor: AppColors.lowPriority),
    //
    // // elevated button theme
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //     style: ElevatedButton.styleFrom(
    //         textStyle: getRegularStyle(color: AppColors.white),
    //         backgroundColor: AppColors.primaryColor,
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(AppSize.s12)))),
    //
    // // Text theme
    // textTheme: TextTheme(
    //     displayLarge: getSemiBoldStyle(
    //         color: AppColors.darkColor, fontSize: AppFontSize.s16),
    //     titleMedium: getMediumStyle(
    //         color: AppColors.lowPriority, fontSize: AppFontSize.s14),
    //     bodySmall: getRegularStyle(color: AppColors.grey),
    //     bodyLarge: getRegularStyle(color: AppColors.grey)),
    // // input decoration theme (text form field)
    //
    // inputDecorationTheme: InputDecorationTheme(
    //   contentPadding: const EdgeInsets.all(AppPadding.p8),
    //   // hint style
    //   hintStyle: getRegularStyle(color: AppColors.grey),
    //
    //   // label style
    //   labelStyle: getMediumStyle(color: AppColors.greyDark),
    //   // error style
    //   errorStyle: getRegularStyle(color: AppColors.redColor),
    //
    //   // enabled border
    //   enabledBorder: OutlineInputBorder(
    //       borderSide: BorderSide(color: AppColors.grey, width: AppSize.s1_5),
    //       borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    //
    //   // focused border
    //   focusedBorder: OutlineInputBorder(
    //       borderSide:
    //           BorderSide(color: AppColors.primaryColor, width: AppSize.s1_5),
    //       borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    //
    //   // error border
    //   errorBorder: OutlineInputBorder(
    //       borderSide:
    //           BorderSide(color: AppColors.redColor, width: AppSize.s1_5),
    //       borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    //   // focused error border
    //   focusedErrorBorder: OutlineInputBorder(
    //       borderSide:
    //           BorderSide(color: AppColors.primaryColor, width: AppSize.s1_5),
    //       borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    // )
  );
}

ThemeData getDarkApplicationTheme() {
  return ThemeData.dark().copyWith(
      colorScheme: const ColorScheme.light()
          .copyWith(primary: AppColors.primaryColor, shadow: AppColors.white),
      // main colors of the app
      primaryColor: AppColors.primaryColor,
      shadowColor: AppColors.lowPriority,
      primaryColorDark: AppColors.darkColor,
      disabledColor: AppColors.grey,
      // ripple color
      splashColor: AppColors.primaryColor,
      // will be used incase of disabled button for example
      hintColor: AppColors.grey,
      // card view theme
      cardTheme: CardTheme(
          color: AppColors.white,
          shadowColor: AppColors.grey,
          elevation: AppSize.s4),
      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: AppColors.primaryColor,
          elevation: AppSize.s4,
          shadowColor: AppColors.lowPriority,
          titleTextStyle: getRegularStyle(
              color: AppColors.white, fontSize: AppFontSize.s16)),
      // Button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: AppColors.greyDark,
          buttonColor: AppColors.primaryColor,
          splashColor: AppColors.lowPriority),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: AppColors.white),
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),

      // Text theme
      textTheme: TextTheme(
          displayLarge: getSemiBoldStyle(
              color: AppColors.darkColor, fontSize: AppFontSize.s16),
          titleMedium: getMediumStyle(
              color: AppColors.lowPriority, fontSize: AppFontSize.s14),
          bodySmall: getRegularStyle(color: AppColors.grey),
          bodyLarge: getRegularStyle(color: AppColors.grey)),
      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getRegularStyle(color: AppColors.grey),

        // label style
        labelStyle: getMediumStyle(color: AppColors.greyDark),
        // error style
        errorStyle: getRegularStyle(color: AppColors.redColor),

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.primaryColor, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.redColor, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.primaryColor, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
