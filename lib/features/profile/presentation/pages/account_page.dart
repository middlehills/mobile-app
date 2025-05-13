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
        body: Padding(
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
                        text: "Account Details",
                        fontSize: 20,
                      ),
                      heightSpacing(8),
                      MidhillTexts.text400(
                        context,
                        text: "Update Details",
                        fontSize: 14,
                        color: const Color(0xff6C7A93),
                      ),
                    ],
                  ),
                  heightSpacing(32),

                  // phone number textfield
                  MidhillTextField(
                    label: "Account Name",
                    isObscure: false,
                    focusNode: focusNodes[0],
                    controller: controllers[0],
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: AuthFunctions.validateFullName,
                    onFieldSubmitted: (string) {
                      FocusScope.of(context).requestFocus(focusNodes[1]);
                    },
                  ),

                  // pin textfield
                  MidhillTextField(
                    label: "Account Number",
                    isObscure: true,
                    focusNode: focusNodes[1],
                    controller: controllers[1],
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    textInputType: TextInputType.number,
                    // validator: (value) =>
                    //     AuthFunctions.validatePhoneumber(value),
                  ),

                  heightSpacing(32),

                  midhillButton(
                    context,
                    onPressed: () {
                      bool? result = _formKey.currentState?.validate();

                      if (result == true) {
                        // context.goNamed(MidhillRoutesList.signInOtpPage);
                      }
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
