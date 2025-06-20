import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/error_dialog_content_widget.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_provider.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, ((index) => TextEditingController()));
    focusNodes = List.generate(4, ((index) => FocusNode()));
  }

  @override
  Widget build(BuildContext context) {
    return midhillAnnotatedRegion(
      barColor: MidhillColors.primaryColor,
      child: Scaffold(
        appBar: midhillAppBar(context),
        backgroundColor: MidhillColors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Consumer2<AuthProvider, ApiUrlProvider>(
            builder: (BuildContext context, AuthProvider value, value2,
                    Widget? child) =>
                SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSpacing(30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MidhillTexts.text700(
                        context,
                        text: "Welcome back!",
                        fontSize: 20,
                      ),
                      heightSpacing(8),
                      MidhillTexts.text400(
                        context,
                        text: "Enter 4-digit PIN to access your account",
                        fontSize: 14,
                        color: const Color(0xff6C7A93),
                      ),
                      heightSpacing(24),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      7,
                      (index) => index % 2 == 0
                          ? buildOtpField(
                              context,
                              index: index == 0 ? 0 : index ~/ 2,
                              controllers: controllers,
                              focusNodes: focusNodes,
                            )
                          : widthSpacing(10),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          value.setForgotPasswordCheck(true);
                          context.goNamed(
                            MidhillRoutesList.loginForgotPasswordPage,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                            right: 8,
                            left: 8,
                          ),
                          child: MidhillTexts.text400(
                            context,
                            text: "Forgot Password",
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            color: MidhillColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  midhillButton(
                    context,
                    onPressed: () async {
                      bool result = await value.login(
                        baseUrl: value2.apiUrl!,
                        pin: controllers.map((e) => e.text).join(),
                      );
                      if (context.mounted) {
                        if (result) {
                          context.goNamed(MidhillRoutesList.navBarPage);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: ErrorDialogContent(
                                  errorHeader: "Login error",
                                  errror: value.loginApiResponse?.message ??
                                      "Failed to login",
                                ),
                              );
                            },
                          );
                        }
                      }
                    },
                    text: "Login",
                    isEnabled: controllers.every(
                        (controller) => controller.value.text.isNotEmpty),
                    isLoading: value.isLoggingIn,
                  ),
                  heightSpacing(16),
                  InkWell(
                    onTap: () {
                      context.goNamed(MidhillRoutesList.onboardingPage);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: MidhillColors.primaryColor,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: MidhillTexts.text600(
                        context,
                        text: "Sign into another account",
                        color: MidhillColors.primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  heightSpacing(15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
