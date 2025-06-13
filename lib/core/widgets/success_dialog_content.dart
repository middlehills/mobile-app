import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

class SuccessDialogContent extends StatelessWidget {
  const SuccessDialogContent({
    super.key,
    required this.successHeader,
    required this.successMessage,
  });

  final String successHeader;
  final String successMessage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Icon(
          //   Icons.succ,
          //   color: Colors.red,
          //   size: 24,
          // ),
          Image.asset(
            MidhillAssets.customImage(
              iconName: "success",
            ),
            height: 28,
            fit: BoxFit.fitHeight,
            color: MidhillColors.primaryColor,
          ),
          heightSpacing(
            mediaQueryHeight(context) * 0.015,
          ),
          MidhillTexts.text600(
            context,
            text: successHeader,
            fontSize: 24,
          ),
          heightSpacing(
            mediaQueryHeight(context) * 0.01,
          ),
          MidhillTexts.text400(
            context,
            text: successMessage,
            fontSize: 16,
          ),
          heightSpacing(
            mediaQueryHeight(context) * 0.02,
          ),
          InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xffEDF0F3),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: MidhillTexts.text600(
                context,
                text: "Continue",
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
