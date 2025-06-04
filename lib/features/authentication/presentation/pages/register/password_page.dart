import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/back_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/dialog_content_widget.dart';
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

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  final _formKey = GlobalKey<FormState>();

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
          child: Consumer2<ApiUrlProvider, AuthProvider>(
            builder: (BuildContext context, ApiUrlProvider value,
                    AuthProvider value2, Widget? child) =>
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
                        text: "Create your 4-digit pin",
                        fontSize: 20,
                      ),
                      heightSpacing(8),
                      MidhillTexts.text400(
                        context,
                        text: "You will use this pin to enter this app",
                        fontSize: 14,
                        color: const Color(0xff6C7A93),
                      ),
                      heightSpacing(24),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Row(
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
                            : widthSpacing(8),
                      ),
                    ),
                  ),
                  heightSpacing(40),
                  midhillButton(
                    context,
                    onPressed: () async {
                      bool result = await value2.createAccount(
                          baseUrl: value.apiUrl!,
                          pin: controllers.map((e) => e.text).join());

                      if (context.mounted) {
                        if (result) {
                          context.goNamed(MidhillRoutesList.otpPage);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: MidhillColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                content: DialogContent(
                                  errorHeader: "Sign Up Error",
                                  errror: value2
                                          .createAccountApiResponse!.message ??
                                      "An error occurred while creating your account. Please try again.",
                                ),
                              );
                            },
                          );
                        }
                      }
                    },
                    isLoading: value2.isCreatingAccount,
                    isEnabled: controllers.every(
                      (controller) => controller.value.text.isNotEmpty,
                    ),
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
