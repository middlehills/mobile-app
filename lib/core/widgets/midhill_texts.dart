import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/theme/midhill_styles.dart';

class MidhillTexts {
  MidhillTexts._();

  static text400({
    required String text,
    required TextAlign textAlign,
    Color color = MidhillColors.black,
    double fontSize = 14,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: MidhillStyles.textStyle(
        color: const Color(0xffB3B3B3),
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
