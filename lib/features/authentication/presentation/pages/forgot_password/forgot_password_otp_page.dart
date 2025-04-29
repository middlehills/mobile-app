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

class ForgotPasswordOtpPage extends StatefulWidget {
  const ForgotPasswordOtpPage({super.key});

  @override
  State<ForgotPasswordOtpPage> createState() => _ForgotPasswordOtpPageState();
}

class _ForgotPasswordOtpPageState extends State<ForgotPasswordOtpPage> {
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
          child: SingleChildScrollView(
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
                      text: "Enter OTP code",
                      fontSize: 20,
                    ),
                    heightSpacing(8),
                    MidhillTexts.text400(
                      text:
                          "We sent a one-time verification code to your phone number *****65",
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
                heightSpacing(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MidhillTexts.text400(
                        text: "You didn’t receive any code? ",
                        color: const Color(0xff6C7A93)),
                    MidhillTexts.text400(
                      text: "Resend Code.",
                      color: MidhillColors.black,
                    ),
                  ],
                ),
                heightSpacing(30),
                InkWell(
                  child: SizedBox(
                    height: 50,
                    child: midhillButton(
                      context,
                      onPressed: () {
                        context
                            .goNamed(MidhillRoutesList.forgotPasswordOtpPage);
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
    );
  }
}
