import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_provider.dart';
import 'package:mid_hill_cash_flow/features/home/domain/upload_provider.dart';
import 'package:mid_hill_cash_flow/features/home/domain/validation_functions.dart';
import 'package:mid_hill_cash_flow/features/home/presentation/components/record_review_modal_sheet.dart';
import 'package:mid_hill_cash_flow/features/profile/domain/profile_provider.dart';
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
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
                      SvgPicture.asset(
                        MidhillAssets.customIcon(
                          iconName: "support",
                        ),
                      ),
                      widthSpacing(16),
                      SvgPicture.asset(
                        MidhillAssets.customIcon(
                          iconName: "bell",
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
                    text: value.uploads.isEmpty
                        ? "Upload"
                        : "Upload ${value.uploads.length + 1} record${(value.uploads.length + 1) == 1 ? "" : "s"}",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        focusNodes.every((e) {
                          e.unfocus();
                          return true;
                        });
                        value.setAddingNewRecordState(false);

                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          barrierLabel: "Tap here to go back",
                          builder: (context) {
                            return PopScope(
                              canPop: true,
                              onPopInvokedWithResult: (didPop, result) {
                                if (!value.isAddingNewRecord) {
                                  value
                                      .clearRecords(); // clear records if user pops screen.
                                } else {
                                  for (var controller in controllers) {
                                    controller.clear();
                                  }

                                  focusNodes[0].requestFocus();
                                }
                              },
                              child: RecordReviewModalSheet(
                                itemName: controllers[0].text.trim(),
                                quantity: controllers[1].text.trim(),
                                amount: int.parse(controllers[2].text.trim()),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),

                  heightSpacing(10),

                  if (value.uploads.isNotEmpty)
                    InkWell(
                      onTap: () {
                        value.setAddingNewRecordState(false);
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          barrierLabel: "Tap here to go back",
                          builder: (context) {
                            return PopScope(
                              canPop: true,
                              onPopInvokedWithResult: (didPop, result) {
                                if (!value.isAddingNewRecord) {
                                  value
                                      .clearRecords(); // clear records if user pops screen.
                                } else {
                                  for (var controller in controllers) {
                                    controller.clear();
                                  }

                                  focusNodes[0].requestFocus();
                                }
                              },
                              child: const RecordReviewModalSheet(
                                itemName: null,
                                quantity: null,
                                amount: null,
                              ),
                            );
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
                              "Upload ${value.uploads.length} existing record${value.uploads.length == 1 ? "" : "s"}",
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
    );
  }
}
