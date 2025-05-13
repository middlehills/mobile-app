// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:kayak_loop/core/theme/assets.dart';
// import 'package:kayak_loop/core/theme/kayak_colors.dart';
// import 'package:kayak_loop/core/theme/kayak_styles.dart';
// import 'package:kayak_loop/core/utils/dropable_model.dart';
// import 'package:kayak_loop/core/widgets/kayak_texts.dart';

// class GenericDropDown<T extends DropableModel> extends StatelessWidget {
//   const GenericDropDown(
//       {super.key, required this.options, required this.onChanged, this.value});
//   final List<T> options;
//   final void Function(T?) onChanged;
//   final T? value;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton(
//       value: value,
//       items: options
//           .map(
//             (e) => DropdownMenuItem<T?>(
//               value: e,
//               child: KayakTexts.appText(
//                 context,text: e.name,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           )
//           .toList(),
//       alignment: Alignment.centerLeft,
//       borderRadius: BorderRadius.circular(4),
//       dropdownColor: Colors.white,
//       icon: SvgPicture.asset(
//         KayakAssets.customIcon(
//           iconName: "arrow-down",
//         ),
//         height: 8.02,
//       ),
//       isExpanded: true,
//       underline: const SizedBox(),
//       hint: KayakTexts.appText(
//         context,text: "Select",
//         color: KayakColors.textLightGrey,
//         size: 14,
//       ),
//       onChanged: (value) {
//         onChanged(value);
//       },
//       style: KayakStyles.textStyle(
//         fontSize: 15,
//         fontWeight: FontWeight.w600,
//         color: KayakColors.textBlack,
//       ),
//     );
//   }
// }
