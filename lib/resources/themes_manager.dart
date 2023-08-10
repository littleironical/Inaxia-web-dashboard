import 'package:flutter/material.dart';
import 'package:inaxia_catalogue/resources/colors_manager.dart';
import 'package:inaxia_catalogue/resources/values_manager.dart';

ThemeData get appThemeData {
  return ThemeData(
    splashColor: ColorsManager.transparent,

    appBarTheme: const AppBarTheme(
      backgroundColor: ColorsManager.primary,
      centerTitle: true,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorsManager.black,
        backgroundColor: ColorsManager.white,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: ColorsManager.black, 
          width: AppWidgetWidthManager.sw1,
        ),
        foregroundColor: ColorsManager.black,
      ),
    ),

    sliderTheme: const SliderThemeData(
      trackHeight: AppWidgetHeightManager.sh8,
      thumbColor: ColorsManager.primary,
      activeTickMarkColor: ColorsManager.primary,
      inactiveTickMarkColor: ColorsManager.transparent,
      activeTrackColor: ColorsManager.primary,
      inactiveTrackColor: ColorsManager.primaryAccent,
      overlayColor: ColorsManager.transparent,
      thumbShape: RoundSliderThumbShape(
        elevation: AppWidgetHeightManager.sh0,
      ),
    ),

    switchTheme: const SwitchThemeData(
      overlayColor: MaterialStatePropertyAll(ColorsManager.transparent),
      thumbColor: MaterialStatePropertyAll(ColorsManager.primary),
      trackColor: MaterialStatePropertyAll(ColorsManager.primaryAccent),
    ),
  );
}
