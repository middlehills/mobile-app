import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mid_hill_cash_flow/core/widgets/back_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/error_dialog_content_widget.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/core/widgets/success_dialog_content.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_provider.dart';
import 'package:mid_hill_cash_flow/features/home/domain/validation_functions.dart';
import 'package:mid_hill_cash_flow/features/profile/domain/profile_provider.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';
import 'package:provider/provider.dart';

class SecurityChangePinPage extends StatefulWidget {
  const SecurityChangePinPage({super.key});

  @override
  State<SecurityChangePinPage> createState() => _SecurityChangePinPageState();
}

class _SecurityChangePinPageState extends State<SecurityChangePinPage> {
  // final pageViewController = PageController();

  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

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
      child: Consumer3<ProfileProvider, AuthProvider, ApiUrlProvider>(
        builder: (BuildContext context, ProfileProvider value,
                AuthProvider value2, ApiUrlProvider value3, Widget? child) =>
            Scaffold(
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
                  MidhillTexts.text600(
                    context,
                    text: "Security",
                    fontSize: 24,
                  ),
                  heightSpacing(16),
                  MidhillTexts.text400(
                    context,
                    text: "Change PIN",
                    fontSize: 20,
                    color: const Color(0xff777777),
                  ),
                  heightSpacing(10),
                  Form(
                    key: _formKey1,
                    child: MidhillTextField(
                      label: "Enter Current PIN",
                      hintText: "****",
                      isObscure: true,
                      focusNode: focusNodes[0],
                      controller: controllers[0],
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(r' '),
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      validator: ValidationFunctions.validatePin,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: MidhillTexts.text400(
                          context,
                          text: "Click on this button to get OTP:",
                          fontSize: 16,
                          color: MidhillColors.dartkGradientColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: InkWell(
                          onTap: () async {
                            if (_formKey1.currentState?.validate() == true) {
                              bool result = await value.checkPin(
                                baseUrl: value3.apiUrl!,
                                pin: controllers.first.text,
                              );

                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: result
                                          ? SuccessDialogContent(
                                              successHeader: "Request Success",
                                              successMessage: value
                                                      .checkPinApiResponse
                                                      ?.message ??
                                                  "Change pin request was successful, otp has been sent.",
                                            )
                                          : ErrorDialogContent(
                                              errorHeader: "OTP Request",
                                              errror: value.checkPinApiResponse
                                                      ?.message ??
                                                  "Request failed. Please try again",
                                            ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: MidhillColors.dartkGradientColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: value.isCheckingPin
                                ? const CircularProgressIndicator(
                                    color: MidhillColors.white,
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        MidhillAssets.customIcon(
                                          iconName: 'mail',
                                        ),
                                        colorFilter: const ColorFilter.mode(
                                          MidhillColors.white,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      widthSpacing(10),
                                      MidhillTexts.text400(
                                        context,
                                        text: "Get OTP",
                                        fontSize: 18,
                                        color: MidhillColors.white,
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey2,
                    child: Column(
                      children: [
                        MidhillTextField(
                          label: "Enter OTP",
                          hintText: "****",
                          isObscure: true,
                          focusNode: focusNodes[1],
                          controller: controllers[1],
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(r' '),
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          onFieldSubmitted: (p0) {
                            FocusScope.of(context).requestFocus(focusNodes[2]);
                          },
                          textInputAction: TextInputAction.next,
                          validator: ValidationFunctions.validatePin,
                          textInputType: TextInputType.number,
                        ),
                        MidhillTextField(
                          label: "Enter New PIN",
                          hintText: "****",
                          isObscure: true,
                          focusNode: focusNodes[2],
                          controller: controllers[2],
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(r' '),
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          onFieldSubmitted: (p0) {
                            FocusScope.of(context).requestFocus(focusNodes[3]);
                          },
                          textInputAction: TextInputAction.next,
                          validator: ValidationFunctions.validatePin,
                          textInputType: TextInputType.number,
                        ),
                        heightSpacing(16),
                        MidhillTextField(
                          label: "Confirm New PIN",
                          hintText: "****",
                          isObscure: true,
                          focusNode: focusNodes[3],
                          controller: controllers[3],
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(r' '),
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          validator: ValidationFunctions.validatePin,
                          textInputType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  heightSpacing(16),
                  midhillButton(
                    context,
                    onPressed: () async {
                      if (_formKey2.currentState?.validate() == true) {
                        value.setNewPin(controllers[2].text);
                        bool result = await value.changeUserPin(
                          baseUrl: value3.apiUrl!,
                          otp: controllers[1].text,
                          confrimationPin: controllers[3].text,
                        );

                        if (context.mounted) {
                          if (result) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SuccessDialogContent(
                                    successHeader: "PIN Change",
                                    successMessage:
                                        value.changePinApiResponse?.message ??
                                            "PIN Change was successful",
                                  ),
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: ErrorDialogContent(
                                    errorHeader: "PIN Change Error",
                                    errror:
                                        value.changePinApiResponse?.message ??
                                            "PIN Change wasn't successful",
                                  ),
                                );
                              },
                            );
                          }
                        }
                      }
                    },
                    text: 'Change PIN',
                    isEnabled: value.checkPinApiResponse?.statusCode == 200,
                    isLoading: value.isChangingPassword,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
