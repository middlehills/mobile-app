import 'package:flutter/material.dart';
import 'dart:math';

import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/theme/midhill_styles.dart';

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = mediaQueryWidth(context);
    double val = (width / 1400) * maxTextScaleFactor;
    return max(0.69, min(val, maxTextScaleFactor));
  }
}

class MidhillTexts {
  MidhillTexts._();

  static text400(
    BuildContext context, {
    required String text,
    TextAlign textAlign = TextAlign.start,
    Color color = MidhillColors.black,
    double fontSize = 14,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: MidhillStyles.textStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        textDecoration: decoration,
      ),
      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
    );
  }

  static text700(
    BuildContext context, {
    required String text,
    TextAlign textAlign = TextAlign.start,
    Color color = MidhillColors.black,
    double fontSize = 20,
  }) {
    return Text(
      text,
      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
      textAlign: textAlign,
      style: MidhillStyles.textStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static text600(
    BuildContext context, {
    required String text,
    TextAlign textAlign = TextAlign.start,
    Color color = MidhillColors.black,
    double fontSize = 24,
    TextDecoration textDecoration = TextDecoration.none,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
      style: MidhillStyles.textStyle(
        textDecoration: textDecoration,
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
