import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/onboarding/domain/onboarding_provider.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.3,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
    _scaleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check if the user is logged in or not
      final onboardingProvider =
          Provider.of<OnboardingProvider>(context, listen: false);
      onboardingProvider.splashTimer(context);
    });

    return midhillAnnotatedRegion(
      barColor: MidhillColors.lightGradientColor,
      child: Scaffold(
        backgroundColor: MidhillColors.primaryColor,
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
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Image.asset(
                      MidhillAssets.customImage(iconName: "watermark_large"),
                    ),
                  )),
              Center(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset(
                    "assets/logos/app_icon.png",
                    width: 123,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: MidhillTexts.text400(
                    context,
                    text:
                        "MidhillCredits is a mobile app designed to help you track your daily sales effortlessly while also providing access to loans based on your monthly revenue.",
                    textAlign: TextAlign.center,
                    fontSize: 10,
                    color: const Color(0xffB3B3B3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
