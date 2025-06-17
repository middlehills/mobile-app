import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/back_button.dart';
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

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final pageViewController = PageController();

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
      child: Consumer2<AuthProvider, ApiUrlProvider>(
        builder: (BuildContext context, AuthProvider value,
                ApiUrlProvider value2, Widget? child) =>
            Scaffold(
          appBar: midhillAppBar(context),
          backgroundColor: MidhillColors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: PageView.builder(
              itemCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              controller: pageViewController,
              itemBuilder: (context, index) => SingleChildScrollView(
                child: PopScope(
                  canPop: index == 0,
                  onPopInvokedWithResult: (didpop, result) {
                    pageViewController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightSpacing(10),
                      mBackButton(context),
                      heightSpacing(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MidhillTexts.text700(
                            context,
                            text: index == 0 ? "Reset PIN" : "Confirm PIN",
                            fontSize: 20,
                          ),
                          heightSpacing(8),
                          MidhillTexts.text400(
                            context,
                            text: index == 0
                                ? "Please enter your new PIN"
                                : "Please re-enter your new PIN to confirm",
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
                      heightSpacing(40),
                      InkWell(
                        child: SizedBox(
                          height: 50,
                          child: midhillButton(
                            context,
                            onPressed: () async {
                              if (controllers.every((controller) =>
                                  controller.value.text.isNotEmpty)) {
                                if (index == 0) {
                                  for (var controller in controllers) {
                                    controller.clear();
                                  }
                                  pageViewController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                } else {
                                  bool result = await value.changePassword(
                                    baseUrl: value2.apiUrl!,
                                    otpCode: value.otpCode!,
                                    newPin:
                                        controllers.map((e) => e.text).join(),
                                  );
                                  if (context.mounted) {
                                    if (result) {
                                      if (value.isLoginForgotPassword) {
                                        context.goNamed(
                                          MidhillRoutesList.loginPage,
                                        );
                                      } else {
                                        context.goNamed(
                                            MidhillRoutesList.signInPage);
                                      }
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: ErrorDialogContent(
                                              errorHeader: "Verification Error",
                                              errror: value
                                                      .changePasswordApiResponse
                                                      ?.message ??
                                                  "Pin change request failed. Please try again.",
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }
                                }
                              }
                            },
                            isEnabled: controllers.every((controller) =>
                                controller.value.text.isNotEmpty),
                            isLoading: value.isChangingPassword,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
