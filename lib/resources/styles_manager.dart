import 'package:flutter/material.dart';
import 'package:inaxia_official_dashboard_web/resources/fonts_manager.dart';

TextStyle _textStyle(
  FontWeight fontWeight,
  double fontSize,
  Color color,
) {
  return TextStyle(
    fontWeight: fontWeight,
    fontSize: fontSize,
    color: color,
  );
}

// BOLD STYLE
TextStyle boldTextStyleManager({
  required Color color,
  double fontSize = FontSizeManager.f14,
}) {
  return _textStyle(
    FontWeightManager.bold,
    fontSize,
    color,
  );
}

// MEDIUM STYLE
TextStyle mediumTextStyleManager({
  required Color color,
  double fontSize = FontSizeManager.f14,
}) {
  return _textStyle(
    FontWeightManager.medium,
    fontSize,
    color,
  );
}
