import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredText extends StatelessWidget {
  final String text;
  final double blurRadius;
  final TextStyle? style;

  const BlurredText(
    this.text, {
    super.key,
    this.blurRadius = 3.0,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: blurRadius,
        sigmaY: blurRadius,
      ),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
