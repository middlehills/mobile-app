import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/theme/midhill_styles.dart';

PreferredSize midhillAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size(
      mediaQuery(context).width,
      75,
    ),
    child: Container(
      height: 75,
      width: mediaQuery(context).width,
      decoration: const BoxDecoration(
        color: MidhillColors.primaryColor,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              MidhillAssets.customImage(iconName: "watermark_small"),
              fit: BoxFit.fitWidth,
            ),
          ),
          Center(
            child: Image.asset(
              "assets/logos/app_icon.png",
              width: 53,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    ),
  );
}
