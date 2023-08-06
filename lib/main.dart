import 'package:flutter/material.dart';
import 'package:inaxia_official_dashboard_web/home/home_view.dart';
import 'package:inaxia_official_dashboard_web/resources/colors_manager.dart';
import 'package:inaxia_official_dashboard_web/resources/strings_manager.dart';
import 'package:inaxia_official_dashboard_web/resources/themes_manager.dart';

void main() {
  runApp(
    MaterialApp(
      theme: appThemeData,
      home: Scaffold(
        backgroundColor: ColorsManager.white,
        appBar: AppBar(
          title: const Text(StringsManager.appTitle),
        ),
        body: const SingleChildScrollView(
          child: HomeView(),
        ),
      ),
    ),
  );
}
