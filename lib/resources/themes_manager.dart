import 'package:flutter/material.dart';
import 'package:inaxia_official_dashboard_web/resources/colors_manager.dart';
import 'package:inaxia_official_dashboard_web/resources/values_manager.dart';

ThemeData get appThemeData {
  return ThemeData(
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
          width: AppSizeManager.s1,
        ),
        foregroundColor: ColorsManager.black,
      ),
    )
  );
}
