import 'package:flutter/material.dart';
import 'package:inaxia_catalogue/home/home_view.dart';
import 'package:inaxia_catalogue/resources/colors_manager.dart';
import 'package:inaxia_catalogue/resources/strings_manager.dart';
import 'package:inaxia_catalogue/resources/themes_manager.dart';

void main() {
  runApp(
    MaterialApp(
      title: StringsManager.appTitle,
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      home: Scaffold(
        backgroundColor: ColorsManager.white,
        appBar: AppBar(
          title: const Text(StringsManager.appTitle),
        ),
        body: const HomeView(),
      ),
    ),
  );
}
