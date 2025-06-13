import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';

class ErrorDialogContent extends StatelessWidget {
  const ErrorDialogContent({
    super.key,
    required this.errorHeader,
    required this.errror,
  });

  final String errorHeader;
  final String errror;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 24,
          ),
          heightSpacing(
            mediaQueryHeight(context) * 0.015,
          ),
          MidhillTexts.text600(
            context,
            text: errorHeader,
            fontSize: 24,
          ),
          heightSpacing(
            mediaQueryHeight(context) * 0.01,
          ),
          MidhillTexts.text400(
            context,
            text: errror,
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
                text: "Cancel",
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
