import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/features/authentication/presentation/pages/forgot_password/forgot_password_otp_page.dart';
import 'package:mid_hill_cash_flow/features/authentication/presentation/pages/forgot_password/forgot_password_page.dart';
import 'package:mid_hill_cash_flow/features/authentication/presentation/pages/forgot_password/reset_password_page.dart';
import 'package:mid_hill_cash_flow/features/authentication/presentation/pages/login_page.dart';
import 'package:mid_hill_cash_flow/features/authentication/presentation/pages/register/otp_page.dart';
import 'package:mid_hill_cash_flow/features/authentication/presentation/pages/register/password_page.dart';
import 'package:mid_hill_cash_flow/features/authentication/presentation/pages/register/register_page.dart';
import 'package:mid_hill_cash_flow/features/authentication/presentation/pages/sign_in/sign_in_otp_page.dart';
import 'package:mid_hill_cash_flow/features/authentication/presentation/pages/sign_in/sign_in_page.dart';
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
          milliseconds: 400,
        ),
      );
    },
  ),
  // onboarding page
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
    routes: [
      // sign in page
      GoRoute(
        path: MidhillRoutesList.signInPage,
        name: MidhillRoutesList.signInPage,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const SignInPage(),
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
        routes: [
          GoRoute(
            path: MidhillRoutesList.signInOtpPage,
            name: MidhillRoutesList.signInOtpPage,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                child: const SignInOtpPage(),
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
          ),
          GoRoute(
            path: MidhillRoutesList.forgotPasswordPage,
            name: MidhillRoutesList.forgotPasswordPage,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                child: const ForgotPasswordPage(),
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
            routes: [
              GoRoute(
                  path: MidhillRoutesList.forgotPasswordOtpPage,
                  name: MidhillRoutesList.forgotPasswordOtpPage,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      child: const ForgotPasswordOtpPage(),
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
                  routes: [
                    GoRoute(
                      path: MidhillRoutesList.resetPasswordPage,
                      name: MidhillRoutesList.resetPasswordPage,
                      pageBuilder: (context, state) {
                        return CustomTransitionPage(
                          child: const ResetPasswordPage(),
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
                    ),
                  ]),
            ],
          ),
        ],
      ),
      // register page
      GoRoute(
        path: MidhillRoutesList.registerPage,
        name: MidhillRoutesList.registerPage,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const RegisterPage(),
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
        routes: [
          GoRoute(
            path: MidhillRoutesList.passwordPage,
            name: MidhillRoutesList.passwordPage,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                child: const PasswordPage(),
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
          ),
          GoRoute(
            path: MidhillRoutesList.otpPage,
            name: MidhillRoutesList.otpPage,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                child: const OtpPage(),
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
      ),
    ],
  ),
  // login page
  GoRoute(
    path: "/${MidhillRoutesList.loginPage}",
    name: MidhillRoutesList.loginPage,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        child: const LoginPage(),
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
  )
];
