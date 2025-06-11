import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/mid_hill_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_provider.dart';
import 'package:mid_hill_cash_flow/features/home/domain/upload_provider.dart';
import 'package:mid_hill_cash_flow/features/nav_bar/nav_bar_provider.dart';
import 'package:mid_hill_cash_flow/features/profile/domain/profile_provider.dart';
import 'package:mid_hill_cash_flow/features/records/domain/records_provider.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:provider/provider.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MidhillTexts.text600(
            context,
            text: "Logout?",
            fontSize: 29,
          ),
          heightSpacing(
            mediaQueryHeight(context) * 0.01,
          ),
          MidhillTexts.text400(
            context,
            text: "Are you sure you want to logout?",
            fontSize: 16,
          ),
          heightSpacing(
            mediaQueryHeight(context) * 0.02,
          ),
          midhillButton(
            context,
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).reset();
              Provider.of<NavBarProvider>(context, listen: false).reset();
              Provider.of<UploadProvider>(context, listen: false).reset();
              Provider.of<RecordsProvider>(context, listen: false).reset();
              Provider.of<ProfileProvider>(context, listen: false).reset();
              context.pop();
              context.goNamed(MidhillRoutesList.loginPage);
            },
            text: "Logout",
          ),
          heightSpacing(
            mediaQueryHeight(context) * 0.01,
          ),
          InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
              decoration: BoxDecoration(
                // color: const Color(0xffEDF0F3),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: MidhillTexts.text600(
                context,
                text: "Cancel",
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
