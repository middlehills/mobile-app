import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/splash_page.dart';

List<GoRoute> authRoutes = [
  // splash page
  GoRoute(
    path: "/${MidhillRoutesList.splashPage}",
    name: MidhillRoutesList.splashPage,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        child: const SplashPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(
          milliseconds: 950,
        ),
      );
    },
  ),
  // splash page
  GoRoute(
    path: "/${MidhillRoutesList.onboardingPage}",
    name: MidhillRoutesList.onboardingPage,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        child: const OnboardingPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(
          milliseconds: 950,
        ),
      );
    },
  ),
];
