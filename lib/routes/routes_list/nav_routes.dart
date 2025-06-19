import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/features/home/presentation/pages/notification_page.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/routes/routes_list/profile_routes.dart';

List<GoRoute> navRoutes = [
  // detailed page
  ...profileRoutes,
  GoRoute(
    path: MidhillRoutesList.notifyPage,
    name: MidhillRoutesList.notifyPage,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        child: const NotificationPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(
          milliseconds: 250,
        ),
      );
    },
  ),
];
