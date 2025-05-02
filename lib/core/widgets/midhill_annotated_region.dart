import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget midhillAnnotatedRegion({required Widget child, Color? barColor}) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(
      statusBarColor: barColor ?? Colors.transparent,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
    child: SafeArea(child: child),
  );
}

Widget heightSpacing(double height) => SizedBox(
      height: height,
    );
Widget widthSpacing(double width) => SizedBox(
      width: width,
    );

double mediaQueryWidth(BuildContext context) =>
    MediaQuery.sizeOf(context).width;
double mediaQueryHeight(BuildContext context) =>
    MediaQuery.sizeOf(context).height;
