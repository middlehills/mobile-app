import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/theme/midhill_styles.dart';

class MidhillTexts {
  MidhillTexts._();

  static text400({
    required String text,
    TextAlign textAlign = TextAlign.start,
    Color color = MidhillColors.black,
    double fontSize = 14,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: MidhillStyles.textStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static text700({
    required String text,
    TextAlign textAlign = TextAlign.start,
    Color color = MidhillColors.black,
    double fontSize = 20,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: MidhillStyles.textStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static text600({
    required String text,
    TextAlign textAlign = TextAlign.start,
    Color color = MidhillColors.black,
    double fontSize = 24,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: MidhillStyles.textStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
