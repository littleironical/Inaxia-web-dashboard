import 'package:flutter/material.dart';
import 'package:inaxia_catalogue/resources/fonts_manager.dart';

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

// BOLD TEXT STYLE
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

// REGULAR STYLE
TextStyle regularTextStyleManager({
  required Color color,
  double fontSize = FontSizeManager.f14,
}) {
  return _textStyle(
    FontWeightManager.regular,
    fontSize,
    color,
  );
}
