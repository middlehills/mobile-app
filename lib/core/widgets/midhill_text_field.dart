import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/theme/midhill_styles.dart';

class KayakTextField extends StatefulWidget {
  const KayakTextField({
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
  });

  final String label;
  final bool isObscure;
  final String? suffixAsset;
  final String? prefixAsset;
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

  @override
  State<KayakTextField> createState() => _KayakTextFieldState();
}

class _KayakTextFieldState extends State<KayakTextField> {
  bool hasFocus = false;
  @override
  Widget build(BuildContext context) {
    widget.focusNode.addListener(_focusNodeListener);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isSignUpLabel == true
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.label,
                      style: MidhillStyles.textStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: widget.focusNode.hasFocus == true
                            ? MidhillColors.primaryColor
                            : MidhillColors.black,
                      ),
                    ),
                    TextSpan(
                      text: "*",
                      style: MidhillStyles.textStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              )
            : MidhillTexts.text400(
                text: widget.label,
                color: widget.focusNode.hasFocus == true
                    ? MidhillColors.primaryColor
                    : MidhillColors.black,
              ),
        // heightSpacing(5),
        TextFormField(
          textAlignVertical: TextAlignVertical.top,
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: MidhillColors.borderGrey,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: MidhillColors.primaryColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
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
            prefix: widget.prefixAsset == null
                ? null
                : SvgPicture.asset(
                    widget.prefixAsset!,
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

class KayakTextField2 extends StatefulWidget {
  const KayakTextField2({
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
    this.isEnabled = true,
    this.validator,
  });

  final String label;
  final bool isObscure;
  final String? suffixAsset;
  final String? prefixAsset;
  final void Function()? onTapSuffixIcon;
  final FocusNode focusNode;
  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool? isSignUpLabel;
  final String? hintText;
  final bool isEnabled;
  final FormFieldValidator<String>? validator;

  @override
  State<KayakTextField2> createState() => _KayakTextField2State();
}

class _KayakTextField2State extends State<KayakTextField2> {
  bool hasFocus = false;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.focusNode.addListener(_focusNodeListener);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isSignUpLabel == true
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.label,
                      style: MidhillStyles.textStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: widget.focusNode.hasFocus == true
                            ? MidhillColors.primaryColor
                            : MidhillColors.black,
                      ),
                    ),
                    TextSpan(
                      text: "*",
                      style: MidhillStyles.textStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              )
            : Text(
                widget.label,
                style: MidhillStyles.textStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: widget.focusNode.hasFocus == true
                      ? MidhillColors.primaryColor
                      : MidhillColors.black,
                ),
              ),
        heightSpacing(8),
        TextFormField(
          textAlignVertical: TextAlignVertical.bottom,
          cursorHeight: 24,
          enabled: widget.isEnabled,
          validator: widget.validator,
          focusNode: widget.focusNode,
          controller: widget.controller,
          cursorColor: MidhillColors.primaryColor,
          obscureText: widget.isObscure,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          textAlign: TextAlign.start,
          style: MidhillStyles.textStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: MidhillColors.black,
          ),
          autovalidateMode: AutovalidateMode.disabled,
          decoration: InputDecoration(
            constraints: BoxConstraints.tight(
              Size(
                MediaQuery.sizeOf(context).width,
                60,
              ),
            ),
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: MidhillColors.borderGrey,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: MidhillColors.primaryColor,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: const BorderSide(
                color: MidhillColors.primaryColor,
                width: 1,
              ),
            ),
            helperText: "",
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
            prefixIcon: widget.prefixAsset == null
                ? null
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SvgPicture.asset(
                      widget.prefixAsset!,
                      height: 20,
                      fit: BoxFit.fitHeight,
                      colorFilter: widget.focusNode.hasFocus == true
                          ? const ColorFilter.mode(
                              MidhillColors.primaryColor, BlendMode.srcIn)
                          : null,
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
