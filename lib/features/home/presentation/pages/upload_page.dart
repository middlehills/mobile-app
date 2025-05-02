import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/home/domain/validation_functions.dart';
import 'package:mid_hill_cash_flow/features/home/presentation/components/record_review_modal_sheet.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';

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
    return Scaffold(
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
                          text: "John Doe,",
                        ),
                        heightSpacing(5),
                        MidhillTexts.text400(
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
                  hintText: "e.g Golden Morn",
                  validator: ValidationFunctions.validateName,
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
                  validator: ValidationFunctions.validateAmount,
                  onFieldSubmitted: (p0) {},
                ),

                heightSpacing(24),

                midhillButton(
                  context,
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return const RecordReviewModalSheet();
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
