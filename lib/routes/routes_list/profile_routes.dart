import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/features/profile/presentation/pages/account_page.dart';
import 'package:mid_hill_cash_flow/features/profile/presentation/pages/profile_details/profile_details_page.dart';
import 'package:mid_hill_cash_flow/features/profile/presentation/pages/profile_details/profile_otp_page.dart';
import 'package:mid_hill_cash_flow/features/profile/presentation/pages/profile_details/profile_password_page.dart';
import 'package:mid_hill_cash_flow/features/profile/presentation/pages/security/security_change_pin_page.dart';
import 'package:mid_hill_cash_flow/features/profile/presentation/pages/security/security_page.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';

List<GoRoute> profileRoutes = [
  // splash page
  GoRoute(
    path: MidhillRoutesList.profileDetailsPage,
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
    routes: [
      GoRoute(
        path: MidhillRoutesList.profileDetailsPasswordPage,
        name: MidhillRoutesList.profileDetailsPasswordPage,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const ProfilePasswordPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
      GoRoute(
        path: MidhillRoutesList.profileDetailsOtpPage,
        name: MidhillRoutesList.profileDetailsOtpPage,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const ProfileOtpPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
    ],
  ),
  GoRoute(
    path: MidhillRoutesList.securityPage,
    name: MidhillRoutesList.securityPage,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        child: const SecurityPage(),
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
    routes: [
      GoRoute(
        path: MidhillRoutesList.securityChangePinPage,
        name: MidhillRoutesList.securityChangePinPage,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const SecurityChangePinPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
    ],
  ),
  GoRoute(
    path: MidhillRoutesList.accountPage,
    name: MidhillRoutesList.accountPage,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        child: const AccountPage(),
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
