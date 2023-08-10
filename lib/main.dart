import 'package:flutter/material.dart';
import 'package:inaxia_catalogue/home/home_view.dart';
import 'package:inaxia_catalogue/resources/colors_manager.dart';
import 'package:inaxia_catalogue/resources/strings_manager.dart';
import 'package:inaxia_catalogue/resources/themes_manager.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        edgeOffset: 60,
        color: ColorsManager.primary,
        onRefresh: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyApp())),
        child: Scaffold(
          backgroundColor: ColorsManager.white,
          appBar: AppBar(
            title: const Text(StringsManager.appTitle),
          ),
          body: const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: HomeView(),
          ),
        ),
      ),
    );
  }
}
