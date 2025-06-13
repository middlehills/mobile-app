import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/back_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/error_dialog_content_widget.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/core/widgets/success_dialog_content.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_functions.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_provider.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/theme/midhill_styles.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';
import 'package:provider/provider.dart';

class SignInOtpPage extends StatefulWidget {
  const SignInOtpPage({super.key});

  @override
  State<SignInOtpPage> createState() => _SignInOtpPageState();
}

class _SignInOtpPageState extends State<SignInOtpPage> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, ((index) => TextEditingController()));
    focusNodes = List.generate(4, ((index) => FocusNode()));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AuthProvider>(context, listen: false).setTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return midhillAnnotatedRegion(
      barColor: MidhillColors.primaryColor,
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          Provider.of<AuthProvider>(context, listen: false).cancelTimer();
          if (Provider.of<AuthProvider>(context, listen: false)
              .isResendingOtp) {
            Provider.of<AuthProvider>(context, listen: false)
                .setResendOtpState(false);
          }
        },
        child: Scaffold(
          appBar: midhillAppBar(context),
          backgroundColor: MidhillColors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: Consumer2<ApiUrlProvider, AuthProvider>(
              builder: (BuildContext context, ApiUrlProvider value,
                      AuthProvider value2, Widget? child) =>
                  Stack(
                alignment: Alignment.center,
                children: [
                  SingleChildScrollView(
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
                              text: "Enter OTP code",
                              fontSize: 20,
                            ),
                            heightSpacing(8),
                            MidhillTexts.text400(
                              context,
                              text:
                                  "We sent a one-time verification code to your phone number",
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
                                    enabled: !value2.isResendingOtp,
                                  )
                                : widthSpacing(10),
                          ),
                        ),
                        heightSpacing(10),
                        Center(
                          child: InkWell(
                            onTap: () async {
                              if (value2.remainingSeconds == 0 &&
                                  value2.otpExpiryTimer?.isActive != true) {
                                bool result = await value2.resendOtp(
                                    baseUrl: value.apiUrl!);
                                if (context.mounted) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: result
                                            ? const SuccessDialogContent(
                                                successHeader: "OTP Sent!",
                                                successMessage:
                                                    "An OTP has been sent to your number, enter code to continue!",
                                              )
                                            : ErrorDialogContent(
                                                errorHeader: "Resend OTP Error",
                                                errror: value2
                                                        .resendOtpApiResponse
                                                        ?.message ??
                                                    "OTP wasn't sent. Try again or contact support.",
                                              ),
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "You didn’t receive any code? ",
                                      style: MidhillStyles.textStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff6C7A93),
                                      ),
                                    ),
                                    TextSpan(
                                      text: value2.remainingSeconds == 0 &&
                                              value2.otpExpiryTimer?.isActive !=
                                                  true
                                          ? "Tap to Resend Code"
                                          : "Try again in ${AuthFunctions.secondsToDigitalTime(value2.remainingSeconds)}",
                                      style: MidhillStyles.textStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: MidhillColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        heightSpacing(30),
                        InkWell(
                          child: SizedBox(
                            height: 50,
                            child: midhillButton(
                              context,
                              onPressed: () async {
                                bool result = await value2.verifyUser(
                                  baseUrl: value.apiUrl!,
                                  otp: controllers.map((e) => e.text).join(),
                                );
                                if (context.mounted) {
                                  if (result) {
                                    context
                                        .goNamed(MidhillRoutesList.navBarPage);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: ErrorDialogContent(
                                          errorHeader: "Verify Sign In",
                                          errror: value2
                                                  .verifyOtpResponse?.message ??
                                              "An error occurred while verifying your OTP",
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              isEnabled: (controllers.every((controller) =>
                                      controller.value.text.isNotEmpty)) &&
                                  !value2.isResendingOtp,
                              isLoading: value2.isVerifying,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (value2.isResendingOtp) const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
