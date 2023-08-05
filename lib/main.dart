import 'package:flutter/material.dart';
import 'package:inaxia_official_dashboard_web/home/home_view.dart';
import 'package:inaxia_official_dashboard_web/resources/themes_manager.dart';

void main() {
  runApp(MaterialApp(
    theme: appThemeData,
    home: const HomeView(),
  ));
}
