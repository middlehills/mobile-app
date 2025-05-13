import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MidhillTexts.text600(
            context,
            text: "Logout?",
            fontSize: 29,
          ),
          heightSpacing(
            mediaQueryHeight(context) * 0.01,
          ),
          MidhillTexts.text400(
            context,
            text: "Are you sure you want to logout?",
            fontSize: 16,
          ),
          heightSpacing(
            mediaQueryHeight(context) * 0.02,
          ),
          midhillButton(
            context,
            onPressed: () {},
            text: "Logout",
          ),
          heightSpacing(
            mediaQueryHeight(context) * 0.01,
          ),
          InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
              decoration: BoxDecoration(
                // color: const Color(0xffEDF0F3),
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
