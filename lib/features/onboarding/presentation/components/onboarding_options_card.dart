import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

class OnboardingOptionsCard extends StatelessWidget {
  const OnboardingOptionsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MidhillColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 20,
        bottom: 18,
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MidhillTexts.text600(
                context,
                text: "Quick & Easy Loans for Your Business",
              ),
              heightSpacing(8),
              MidhillTexts.text400(
                context,
                text: "Grow your business with quick, hassle-free financing.",
                fontSize: 16,
                color: const Color(0xff6C7A93),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  context.goNamed(MidhillRoutesList.registerPage);
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F7F7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: MidhillTexts.text600(
                    context,
                    text: "Create New Account",
                    fontSize: 14,
                  ),
                ),
              ),
              heightSpacing(8),
              InkWell(
                onTap: () {
                  context.goNamed(MidhillRoutesList.signInPage);
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
                    text: "Sign into existing account",
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
