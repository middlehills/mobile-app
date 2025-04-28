import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
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
                child: Image.asset(
                  MidhillAssets.customImage(iconName: "watermark_large"),
                ),
              ),
              Center(
                child: Image.asset(
                  "assets/logos/app_icon.png",
                  width: 123,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                bottom: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: MidhillTexts.text400(
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
