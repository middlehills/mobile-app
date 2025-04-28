import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';

class OnboardingProvider extends ChangeNotifier {
  Future<void> splashTimer(BuildContext context) async {
    // Still on splash screen for the below Duration
    await Future.delayed(const Duration(milliseconds: 3000));

    // final result = await AuthService.getLoginCheck();
    if (context.mounted) {
      // if (result != null) {
      //   context.goNamed(MidhillRoutesList.loginPage);
      // } else {
      context.goNamed(MidhillRoutesList.onboardingPage);
      // }
    }
  }
}
