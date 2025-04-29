import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/features/onboarding/presentation/components/onboarding_options_card.dart';
import 'package:mid_hill_cash_flow/features/onboarding/presentation/components/onboarding_picture_grid.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return midhillAnnotatedRegion(
      barColor: MidhillColors.lightGradientColor,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                MidhillColors.lightGradientColor,
                MidhillColors.dartkGradientColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  MidhillAssets.customImage(iconName: "watermark_large"),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: OnboardingPictureGrid(),
                    ),
                    heightSpacing(10),
                    const Expanded(
                      flex: 3,
                      child: OnboardingOptionsCard(),
                    ),
                    heightSpacing(10),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
