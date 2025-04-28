import 'package:flutter/material.dart';

class MidhillStyles {
  MidhillStyles._();
  static TextStyle textStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      height: height,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      decoration: textDecoration,
      decorationColor: color,
    );
  }
}
