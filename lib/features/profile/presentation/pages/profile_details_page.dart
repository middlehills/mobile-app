import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mid_hill_cash_flow/core/widgets/back_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_functions.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controllers = List.generate(3, ((index) => TextEditingController()));
    focusNodes = List.generate(3, ((index) => FocusNode()));
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mediaQueryHeight(context) * 0.085,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox.shrink(),
                        const Spacer(),
                        mBackButton(context),
                        const Spacer(),
                        MidhillTexts.text600(context, text: "Profile Details")
                      ],
                    ),
                  ),
                  heightSpacing(mediaQueryHeight(context) * 0.025),
                  // first name textfield
                  MidhillTextField(
                    label: "First Name",
                    isObscure: false,
                    focusNode: focusNodes[0],
                    controller: controllers[0],
                    onFieldSubmitted: (p0) => focusNodes[1].requestFocus(),
                    textInputAction: TextInputAction.next,
                    validator: (value) => AuthFunctions.validateName(value),
                  ),

                  // last name textfield
                  MidhillTextField(
                    label: "Last Name",
                    isObscure: false,
                    focusNode: focusNodes[1],
                    controller: controllers[1],
                    onFieldSubmitted: (p0) => focusNodes[2].requestFocus(),
                    textInputAction: TextInputAction.next,
                    validator: (value) => AuthFunctions.validateName(value),
                  ),

                  // phone number textfield
                  MidhillTextField(
                    label: "Phone Number",
                    isObscure: false,
                    focusNode: focusNodes[2],
                    controller: controllers[2],
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    textInputType: TextInputType.phone,
                    prefixString: "🇳🇬 +234 |",
                    validator: AuthFunctions.validatePhoneumber,
                  ),
                  heightSpacing(32),

                  midhillButton(
                    context,
                    onPressed: () {
                      bool? result = _formKey.currentState?.validate();

                      if (result == true) {}
                    },
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
