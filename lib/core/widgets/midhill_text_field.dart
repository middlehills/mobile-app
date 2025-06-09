import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/theme/midhill_styles.dart';

class MidhillTextField extends StatefulWidget {
  const MidhillTextField({
    super.key,
    required this.label,
    required this.isObscure,
    this.suffixAsset,
    this.prefixAsset,
    this.onTapSuffixIcon,
    required this.focusNode,
    required this.controller,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.done,
    this.isSignUpLabel,
    this.hintText,
    this.validator,
    this.isEnabled = true,
    this.inputFormatters,
    this.textInputType,
    this.prefixString,
    this.textAlignVertical,
  });

  final String label;
  final bool isObscure;
  final String? suffixAsset;
  final String? prefixAsset;
  final String? prefixString;
  final void Function()? onTapSuffixIcon;
  final FocusNode focusNode;
  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool? isSignUpLabel;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool isEnabled;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final TextAlignVertical? textAlignVertical;

  @override
  State<MidhillTextField> createState() => _MidhillTextFieldState();
}

class _MidhillTextFieldState extends State<MidhillTextField> {
  bool hasFocus = false;
  @override
  Widget build(BuildContext context) {
    widget.focusNode.addListener(_focusNodeListener);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MidhillTexts.text400(
          context,
          text: widget.label,
          color: widget.focusNode.hasFocus == true
              ? MidhillColors.primaryColor
              : MidhillColors.black,
          fontSize: 14,
        ),
        heightSpacing(5),
        TextFormField(
          textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.top,
          enabled: widget.isEnabled,
          keyboardType: widget.textInputType,
          cursorHeight: 24,
          focusNode: widget.focusNode,
          controller: widget.controller,
          cursorColor: MidhillColors.primaryColor,
          obscureText: widget.isObscure,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          autovalidateMode: AutovalidateMode.disabled,
          inputFormatters: widget.inputFormatters,
          style: MidhillStyles.textStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: MidhillColors.black,
          ),
          textAlign: TextAlign.start,
          validator: widget.validator,
          decoration: InputDecoration(
            constraints: BoxConstraints.tight(
              Size(
                MediaQuery.sizeOf(context).width,
                60,
              ),
            ),
            hintText: widget.hintText,
            hintStyle: MidhillStyles.textStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xff6C7A93),
            ),
            helperStyle: MidhillStyles.textStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color.fromARGB(26, 89, 89, 89),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: MidhillColors.borderGrey,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: MidhillColors.primaryColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: MidhillColors.primaryColor,
                width: 1,
              ),
            ),
            suffixIcon: widget.suffixAsset == null
                ? null
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: GestureDetector(
                      onTap: widget.onTapSuffixIcon,
                      child: SvgPicture.asset(
                        widget.suffixAsset!,
                        height: 15.71,
                        fit: BoxFit.fitHeight,
                        colorFilter: widget.focusNode.hasFocus == true
                            ? const ColorFilter.mode(
                                MidhillColors.primaryColor, BlendMode.srcIn)
                            : null,
                      ),
                    ),
                  ),
            // prefix: widget.prefixAsset == null
            //     ? null
            //     : SvgPicture.asset(
            //         widget.prefixAsset!,
            //       ),
            prefixIcon: widget.prefixString == null
                ? null
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 8,
                    ),
                    child: MidhillTexts.text400(
                      context,
                      text: widget.prefixString!,
                      fontSize: 16,
                    ),
                  ),
          ),
        )
      ],
    );
  }

  _focusNodeListener() {
    if (mounted) {
      setState(() {});
    }
  }
}

Widget buildOtpField(
  BuildContext context, {
  required int index,
  required List<TextEditingController> controllers,
  required List<FocusNode> focusNodes,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFAFCFE),
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
      border: Border.all(
        color: focusNodes[index].hasFocus
            ? MidhillColors.primaryColor
            : const Color(0xffF6F7F9),
        width: 1,
      ),
    ),
    width: 50,
    height: 50,
    child: TextField(
      controller: controllers[index],
      focusNode: focusNodes[index],
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 1,
      obscuringCharacter: "●",
      obscureText: true,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(1),
      ],
      onChanged: (value) {
        // This condition ensures that the current TextField is not the last one in the sequence.
        // The check index < 5 prevents trying to move focus to a non-existent next field.
        if (value.isNotEmpty && index < 3) {
          FocusScope.of(context).requestFocus(focusNodes[index + 1]);
        }
        //managing focus in an OTP input field where the user may need to move backward when correcting an entry
        else if (value.isEmpty && index > 0) {
          FocusScope.of(context).requestFocus(focusNodes[index - 1]);
        }

        // unfocus the last field when it is filled
        else if (value.isNotEmpty && index == 3) {
          FocusScope.of(context).unfocus();
        }
      },
      decoration: const InputDecoration(
        counterText: "",
        border: InputBorder.none,
        hintText: "*",
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
      ),
    ),
  );
}
