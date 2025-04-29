import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/back_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_functions.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                        text: "Welcome back!",
                        fontSize: 20,
                      ),
                      heightSpacing(8),
                      MidhillTexts.text400(
                        text: "Enter 4-digit PIN to use application",
                        fontSize: 14,
                        color: const Color(0xff6C7A93),
                      ),
                    ],
                  ),
                  heightSpacing(32),

                  // phone number textfield
                  MidhillTextField(
                    label: "Phone Number",
                    isObscure: false,
                    focusNode: focusNodes[0],
                    controller: controllers[0],
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    textInputType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    prefixString: "🇳🇬 +234 |",
                    validator: (value) =>
                        AuthFunctions.validatePhoneumber(value),
                    onFieldSubmitted: (string) {
                      FocusScope.of(context).requestFocus(focusNodes[1]);
                    },
                  ),

                  // pin textfield
                  MidhillTextField(
                    label: "Enter PIN",
                    isObscure: true,
                    focusNode: focusNodes[1],
                    controller: controllers[1],
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    textInputType: TextInputType.number,
                    // validator: (value) =>
                    //     AuthFunctions.validatePhoneumber(value),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          context.goNamed(MidhillRoutesList.forgotPasswordPage);
                        },
                        child: SizedBox(
                          height: 20,
                          child: MidhillTexts.text600(
                            text: "Forgot PIN",
                            textDecoration: TextDecoration.underline,
                            color: MidhillColors.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),

                  heightSpacing(32),

                  midhillButton(
                    context,
                    onPressed: () {
                      bool? result = _formKey.currentState?.validate();

                      if (result == true) {
                        context.goNamed(MidhillRoutesList.signInOtpPage);
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
