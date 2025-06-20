import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mid_hill_cash_flow/core/widgets/back_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_functions.dart';
import 'package:mid_hill_cash_flow/features/profile/domain/mono_config.dart';
import 'package:mid_hill_cash_flow/features/profile/domain/profile_provider.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';
import 'package:mono_connect/mono_connect.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controllers = List.generate(2, ((index) => TextEditingController()));
    focusNodes = List.generate(2, ((index) => FocusNode()));
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return midhillAnnotatedRegion(
      barColor: MidhillColors.primaryColor,
      child: Scaffold(
        appBar: midhillAppBar(context),
        body: Consumer<ProfileProvider>(
          builder:
              (BuildContext context, ProfileProvider value, Widget? child) =>
                  Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSpacing(10),
                    mBackButton(context),
                    heightSpacing(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MidhillTexts.text600(
                          context,
                          text: value.midhillUser?.monoId == null
                              ? "Link Bank Account"
                              : "Your account is already linked",
                          fontSize: 20,
                        ),
                        if (value.midhillUser?.monoId != null) heightSpacing(8),
                        if (value.midhillUser?.monoId != null)
                          MidhillTexts.text400(
                            context,
                            text:
                                "Your account is already linked. Continue if you want to replace account.",
                            fontSize: 14,
                            color: const Color(0xff6C7A93),
                          ),
                      ],
                    ),
                    heightSpacing(32),

                    // email textfield
                    MidhillTextField(
                      label: "Email Address",
                      isObscure: false,
                      focusNode: focusNodes[0],
                      controller: controllers[0],
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: AuthFunctions.validateEmail,
                    ),
                    MidhillTextField(
                      label: "Bank Verification Number(BVN)",
                      isObscure: false,
                      focusNode: focusNodes[1],
                      controller: controllers[1],
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      textInputAction: TextInputAction.next,
                      validator: AuthFunctions.validateBVN,
                    ),

                    heightSpacing(24),

                    midhillButton(
                      context,
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          MonoConnect.launch(
                            context,
                            config: createConfig(
                              name:
                                  "${value.midhillUser!.firstName} ${value.midhillUser!.lastName}",
                              email: controllers[0].text.trim(),
                              identity: controllers[1].text.trim(),
                              profileValue: value,
                              apiUrlProviderValue: Provider.of<ApiUrlProvider>(
                                context,
                                listen: false,
                              ),
                              context: context,
                            ),
                            showLogs: false,
                          );
                        }
                      },
                      isLoading: value.isConnectingMono || value.isFetchingUser,
                      text: 'Link Account',
                    ),
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
