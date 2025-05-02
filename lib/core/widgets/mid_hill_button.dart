import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

InkWell midhillButton(
  BuildContext context, {
  required void Function()? onPressed,
  bool isLoading = false,
  bool isEnabled = true,
  String text = "Continue",
}) {
  return InkWell(
    onTap: isEnabled ? onPressed : null,
    child: Container(
      width: MediaQuery.sizeOf(context).width,
      height: 50,
      decoration: BoxDecoration(
        color: isEnabled ? MidhillColors.primaryColor : const Color(0xffEDF0F3),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: isLoading
          ? const CircularProgressIndicator(
              color: MidhillColors.white,
            )
          : MidhillTexts.text600(
              text: text,
              fontSize: 16,
              color: isEnabled ? MidhillColors.white : MidhillColors.borderGrey,
            ),
    ),
  );
}
