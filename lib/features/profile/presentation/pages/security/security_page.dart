import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/back_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return midhillAnnotatedRegion(
      barColor: MidhillColors.primaryColor,
      child: Scaffold(
        appBar: midhillAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
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
                      MidhillTexts.text600(
                        context,
                        text: "Security",
                      ),
                    ],
                  ),
                ),
                heightSpacing(mediaQueryHeight(context) * 0.025),
                InkWell(
                  onTap: () {
                    context.goNamed(MidhillRoutesList.securityChangePinPage);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0x82777777),
                        ),
                      ),
                    ),
                    height: mediaQueryHeight(context) * 0.08,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          MidhillAssets.customIcon(
                            iconName: 'key',
                          ),
                          colorFilter: const ColorFilter.mode(
                            Color(0xCC121212),
                            BlendMode.srcIn,
                          ),
                        ),
                        widthSpacing(8),
                        MidhillTexts.text400(
                          context,
                          text: 'Change PIN',
                          fontSize: 20,
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          MidhillAssets.customIcon(
                            iconName: 'arrow-right',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
