import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/dialog_content_widget.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_provider.dart';
import 'package:mid_hill_cash_flow/features/home/domain/upload_provider.dart';
import 'package:mid_hill_cash_flow/features/nav_bar/nav_bar_provider.dart';
import 'package:mid_hill_cash_flow/features/profile/domain/profile_provider.dart';
import 'package:mid_hill_cash_flow/features/records/domain/records_provider.dart';
import 'package:mid_hill_cash_flow/routes/midhill_routes_list.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';
import 'package:provider/provider.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfileProvider, ApiUrlProvider>(
      builder: (BuildContext context, ProfileProvider value,
              ApiUrlProvider value2, Widget? child) =>
          SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MidhillTexts.text600(
              context,
              text: "Delete Account?",
              fontSize: 29,
            ),
            heightSpacing(
              mediaQueryHeight(context) * 0.01,
            ),
            MidhillTexts.text400(
              context,
              text:
                  "Are you sure you want to delete this account? This action cannot be reversed.",
              fontSize: 16,
            ),
            heightSpacing(
              mediaQueryHeight(context) * 0.02,
            ),
            InkWell(
              onTap: () async {
                if (!value.isDeletingAccount) {
                  bool result =
                      await value.deleteAccount(baseUrl: value2.apiUrl!);
                  if (context.mounted) {
                    if (result) {
                      Provider.of<AuthProvider>(context, listen: false).reset();
                      Provider.of<NavBarProvider>(context, listen: false)
                          .reset();
                      Provider.of<UploadProvider>(context, listen: false)
                          .reset();
                      Provider.of<RecordsProvider>(context, listen: false)
                          .reset();
                      value.reset();
                      context.goNamed(MidhillRoutesList.onboardingPage);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: DialogContent(
                              errorHeader: "Delete Account Error",
                              errror: value.deleteAccountApiResponse?.message ??
                                  "Error ocurred while deleting account",
                            ),
                          );
                        },
                      );
                    }
                  }
                }
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xffB00C0C),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: value.isDeletingAccount
                    ? const CircularProgressIndicator(
                        color: MidhillColors.white,
                      )
                    : MidhillTexts.text600(
                        context,
                        text: "Delete Account",
                        fontSize: 16,
                        color: MidhillColors.white,
                      ),
              ),
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
      ),
    );
  }
}
