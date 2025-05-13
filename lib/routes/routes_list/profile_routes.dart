import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/features/profile/presentation/pages/profile_details_page.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';

List<GoRoute> profileRoutes = [
  // splash page
  GoRoute(
    path: "/${MidhillRoutesList.profileDetailsPage}",
    name: MidhillRoutesList.profileDetailsPage,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        child: const ProfileDetailsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(
          milliseconds: 300,
        ),
      );
    },
  ),
];
