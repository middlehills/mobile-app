import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/features/nav_bar/presentation/screens/nav_bar_page.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/routes/routes_list/auth_routes.dart';

class MidhillRouter {
  static final returnRouter = GoRouter(
    initialLocation: "/${MidhillRoutesList.splashPage}",
    routes: [
      ...authRoutes,
      GoRoute(
        path: "/${MidhillRoutesList.navBarPage}",
        name: MidhillRoutesList.navBarPage,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const NavBarPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
      )
    ],
  );
}
