import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mid_hill_cash_flow/core/widgets/error_dialog_content_widget.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_text_field.dart';
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

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({
    super.key,
  });

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, ((index) => TextEditingController()));
    focusNodes = List.generate(4, ((index) => FocusNode()));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AuthProvider>(context, listen: false).setTimer();
    });
  }

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
                  '''Are you sure you want to delete this account? This action cannot be reversed.\n\n'''
                  '''Enter your PIN to continue:''',
              fontSize: 16,
            ),
            heightSpacing(
              mediaQueryHeight(context) * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                7,
                (index) => index % 2 == 0
                    ? buildOtpField(
                        context,
                        index: index == 0 ? 0 : index ~/ 2,
                        controllers: controllers,
                        focusNodes: focusNodes,
                        enabled: !value.isDeletingAccount,
                      )
                    : widthSpacing(10),
              ),
            ),
            heightSpacing(
              mediaQueryHeight(context) * 0.02,
            ),
            InkWell(
              onTap: () async {
                if (!value.isDeletingAccount &&
                    controllers.every((e) => e.text.isNotEmpty)) {
                  bool result = await value.deleteAccount(
                    baseUrl: value2.apiUrl!,
                    pin: controllers.map((cont) => cont.text).join(),
                  );
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
                      context.pop();
                      context.goNamed(MidhillRoutesList.onboardingPage);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: ErrorDialogContent(
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
                  color: controllers.every((e) => e.text.isNotEmpty)
                      ? const Color(0xffB00C0C)
                      : const Color(0xffEDF0F3),
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
                        color: controllers.every((e) => e.text.isNotEmpty)
                            ? MidhillColors.white
                            : MidhillColors.borderGrey,
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
