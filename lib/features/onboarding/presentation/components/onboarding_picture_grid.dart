import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

class OnboardingPictureGrid extends StatelessWidget {
  const OnboardingPictureGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                heightSpacing(10),
                Expanded(
                  flex: 4,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: MidhillColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(24),
                      ),
                    ),
                    child: Image.asset(
                      MidhillAssets.customImage(
                        iconName: "onboarding3",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                heightSpacing(10),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: MidhillColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      MidhillAssets.customImage(
                        iconName: "onboarding1",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
          widthSpacing(15),
          Expanded(
            child: Column(
              children: [
                heightSpacing(10),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: MidhillColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                        bottomLeft: Radius.circular(4),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      MidhillAssets.customImage(
                        iconName: "onboarding4",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                heightSpacing(10),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: MidhillColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      MidhillAssets.customImage(
                        iconName: "onboarding2",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
