import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({
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
            text: "Delete Account?",
            fontSize: 29,
          ),
          heightSpacing(
            mediaQueryHeight(context) * 0.01,
          ),
          MidhillTexts.text400(
            context,
            text:
                "Are you sure you want to delete this account? This action cannot be reversed.",
            fontSize: 16,
          ),
          heightSpacing(
            mediaQueryHeight(context) * 0.02,
          ),
          InkWell(
            onTap: () {
              context.goNamed(MidhillRoutesList.signInPage);
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xffB00C0C),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: MidhillTexts.text600(
                context,
                text: "Delete Account",
                fontSize: 16,
                color: MidhillColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
