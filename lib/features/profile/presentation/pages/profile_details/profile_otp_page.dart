import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/back_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/dialog_content_widget.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_functions.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_provider.dart';
import 'package:mid_hill_cash_flow/features/profile/domain/profile_provider.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/theme/midhill_styles.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';
import 'package:provider/provider.dart';

class ProfileOtpPage extends StatefulWidget {
  const ProfileOtpPage({super.key});

  @override
  State<ProfileOtpPage> createState() => _ProfileOtpPageState();
}

class _ProfileOtpPageState extends State<ProfileOtpPage> {
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
      child: Consumer3<ProfileProvider, AuthProvider, ApiUrlProvider>(
        builder: (BuildContext context, ProfileProvider value, value2,
                ApiUrlProvider value3, Widget? child) =>
            Scaffold(
          appBar: midhillAppBar(context),
          backgroundColor: MidhillColors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: Stack(
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
                                "We sent a one-time verification code to your phone number *****${(value.midhillUser?.phoneNumber ?? "").substring(9, 11)}",
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
                              value2.resendOtp(baseUrl: value3.apiUrl!);
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
                              String pin =
                                  controllers.map((e) => e.text).join();
                              bool result =
                                  await value.verifyUpdateProfileDetails(
                                baseUrl: value3.apiUrl!,
                                otpCode: pin,
                              );
                              if (context.mounted) {
                                if (result) {
                                  context.goNamed(MidhillRoutesList.navBarPage);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: DialogContent(
                                          errorHeader: "Verify Update Error",
                                          errror: value
                                                  .verifyUpdateProfileApiResponse
                                                  ?.message ??
                                              "Operation failed due to unkown error",
                                        ),
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            isLoading: value.isProfileUpdateVerifying,
                            isEnabled: (controllers.every((controller) =>
                                    controller.value.text.isNotEmpty)) &&
                                !value2.isResendingOtp,
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
    );
  }
}
