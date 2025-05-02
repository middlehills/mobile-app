import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/back_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

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
      child: Scaffold(
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
                          text: index == 0 ? "Reset PIN" : "Confirm PIN",
                          fontSize: 20,
                        ),
                        heightSpacing(8),
                        MidhillTexts.text400(
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
                          onPressed: () {
                            if (index == 0 &&
                                controllers.every((controller) =>
                                    controller.value.text.isNotEmpty)) {
                              for (var controller in controllers) {
                                controller.clear();
                              }
                              pageViewController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            } else {
                              context.goNamed(
                                MidhillRoutesList.loginPage,
                              );
                            }
                          },
                          isEnabled: controllers.every(
                              (controller) => controller.value.text.isNotEmpty),
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
    );
  }
}
