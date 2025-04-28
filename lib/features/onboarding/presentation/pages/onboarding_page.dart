import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
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
                    Expanded(
                      flex: 5,
                      child: SizedBox.expand(
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
                      ),
                    ),
                    heightSpacing(10),
                    Expanded(
                      flex: 3,
                      child: Container(
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
                                  text: "Quick & Easy Loans for Your Business",
                                ),
                                heightSpacing(8),
                                MidhillTexts.text400(
                                  text:
                                      "Grow your business with quick, hassle-free financing.",
                                  fontSize: 16,
                                  color: const Color(0xff6C7A93),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF7F7F7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: MidhillTexts.text600(
                                    text: "Sign Up with Phone Number",
                                    fontSize: 14,
                                  ),
                                ),
                                heightSpacing(8),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffEDF0F3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: MidhillTexts.text600(
                                    text: "Login",
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
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
