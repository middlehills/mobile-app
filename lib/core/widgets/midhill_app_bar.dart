// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:kayak_loop/core/theme/assets.dart';
// import 'package:kayak_loop/core/theme/kayak_colors.dart';
// import 'package:kayak_loop/core/widgets/kayak_texts.dart';

// AppBar kayakAppBar(BuildContext context,
//     {Color? bgColor,
//     required String title,
//     required Color fgColor,
//     // required Color titleColor,
//     bool showLeading = true}) {
//   return AppBar(
//     backgroundColor: bgColor ?? KayakColors.white,
//     leadingWidth: 35,
//     // forceMaterialTransparency: true,
//     leading: Padding(
//       padding: const EdgeInsets.only(left: 15),
//       child: !showLeading
//           ? const SizedBox()
//           : GestureDetector(
//               onTap: () {
//                 context.pop();
//               },
//               child: SvgPicture.asset(
//                 KayakAssets.customIcon(iconName: "arrow-backward"),
//                 height: 10,
//                 colorFilter: ColorFilter.mode(
//                   fgColor,
//                   BlendMode.srcIn,
//                 ),
//               ),
//             ),
//     ),
//     title: KayakTexts.buttonText(
//       text: title,
//       color: fgColor,
//     ),
//   );
// }
