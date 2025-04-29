import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';

InkWell mBackButton(BuildContext context) {
  return InkWell(
    onTap: () {
      context.pop();
    },
    child: Container(
      alignment: Alignment.center,
      height: 30,
      width: 30,
      child: SvgPicture.asset(
        MidhillAssets.customIcon(
          iconName: "arrow-back",
        ),
        width: 25,
        fit: BoxFit.fitWidth,
      ),
    ),
  );
}
