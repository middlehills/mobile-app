import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_provider.dart';
import 'package:mid_hill_cash_flow/features/home/domain/support_launcher.dart';
import 'package:mid_hill_cash_flow/features/home/domain/upload_provider.dart';
import 'package:mid_hill_cash_flow/features/home/domain/validation_functions.dart';
import 'package:mid_hill_cash_flow/features/home/presentation/components/record_review_modal_sheet.dart';
import 'package:mid_hill_cash_flow/features/profile/domain/profile_provider.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:provider/provider.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({
    super.key,
  });

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      3,
      ((index) => TextEditingController()),
    );
    focusNodes = List.generate(
      3,
      ((index) => FocusNode()),
    );
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
    return Consumer3<AuthProvider, ProfileProvider, UploadProvider>(
      builder: (
        BuildContext context,
        AuthProvider authProvider,
        ProfileProvider profileProvider,
        UploadProvider value,
        Widget? child,
      ) =>
          Scaffold(
        appBar: midhillAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    heightSpacing(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MidhillTexts.text600(
                              context,
                              text: profileProvider.midhillUser == null
                                  ? "${authProvider.midhillUser?.firstName} ${authProvider.midhillUser?.lastName},"
                                  : "${profileProvider.midhillUser?.firstName} ${profileProvider.midhillUser?.lastName},",
                            ),
                            heightSpacing(5),
                            MidhillTexts.text400(
                              context,
                              text: "Enter a new record",
                              fontSize: 13,
                              color: const Color(0xff6C7A93),
                            )
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () async {
                            launchWhatsApp(
                              phone: '+2347050252307',
                              message: 'Hi Midhill Support, [Enter complaint]',
                            );
                          },
                          customBorder: const CircleBorder(),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: SvgPicture.asset(
                              MidhillAssets.customIcon(
                                iconName: "support",
                              ),
                            ),
                          ),
                        ),
                        widthSpacing(16),
                        InkWell(
                          onTap: () async {
                            context.goNamed(MidhillRoutesList.notifyPage);
                          },
                          customBorder: const CircleBorder(),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: SvgPicture.asset(
                              MidhillAssets.customIcon(
                                iconName: "bell",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightSpacing(20),

                    // name field
                    MidhillTextField(
                      label: "Item Name",
                      isObscure: false,
                      focusNode: focusNodes[0],
                      controller: controllers[0],
                      hintText: "e.g Bag of rice",
                      validator: ValidationFunctions.validateItemName,
                      onFieldSubmitted: (p0) {
                        FocusScope.of(context).requestFocus(focusNodes[1]);
                      },
                      textInputAction: TextInputAction.next,
                    ),

                    // quantity field
                    MidhillTextField(
                      label: "Quantity",
                      isObscure: false,
                      focusNode: focusNodes[1],
                      controller: controllers[1],
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textInputType: TextInputType.number,
                      hintText: "e.g 12",
                      validator: ValidationFunctions.validateQuantity,
                      onFieldSubmitted: (p0) {
                        FocusScope.of(context).requestFocus(focusNodes[2]);
                      },
                      textInputAction: TextInputAction.next,
                    ),

                    // amount field
                    MidhillTextField(
                      label: "Amount",
                      isObscure: false,
                      focusNode: focusNodes[2],
                      controller: controllers[2],
                      hintText: "e.g 2000",
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textInputType: TextInputType.number,
                      validator: ValidationFunctions.validateAmount,
                    ),

                    heightSpacing(24),

                    midhillButton(
                      context,
                      text: "Add Item",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          value.createRecord(
                            name: controllers[0].text.trim(),
                            quantity: controllers[1].text.trim(),
                            amount: int.parse(
                              controllers[2].text.trim(),
                            ),
                          );
                          for (var controller in controllers) {
                            controller.clear();
                            FocusScope.of(context).requestFocus(focusNodes[0]);
                          }
                        }
                      },
                    ),

                    heightSpacing(16),

                    if (value.uploads.isNotEmpty)
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              focusNodes.every((e) {
                                e.unfocus();
                                return true;
                              });
                              return const RecordReviewModalSheet();
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MidhillColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: MidhillTexts.text600(
                            context,
                            text:
                                "Submit ${value.uploads.isEmpty ? '' : value.uploads.length} Item${value.uploads.length < 2 ? '' : 's'}",
                            fontSize: 16,
                            color: MidhillColors.primaryColor,
                          ),
                          height: 50,
                        ),
                      ),

                    heightSpacing(20),
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
