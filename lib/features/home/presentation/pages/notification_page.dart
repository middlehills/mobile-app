import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/widgets/back_button.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_annotated_region.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_app_bar.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/core/widgets/success_dialog_content.dart';
import 'package:mid_hill_cash_flow/theme/assets.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: SuccessDialogContent(
              successHeader: "Coming Soon!",
              successMessage: "Notifications feature is not yet provided!",
            ),
          );
        },
      );
    });
    return midhillAnnotatedRegion(
      barColor: MidhillColors.primaryColor,
      child: Scaffold(
        appBar: midhillAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpacing(10),
              mBackButton(context),
              heightSpacing(10),
              Expanded(
                  child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      MidhillAssets.customImage(
                        iconName: 'notify',
                      ),
                    ),
                    heightSpacing(16),
                    MidhillTexts.text600(
                      context,
                      text: "No notifications yet",
                      fontSize: 18,
                    ),
                    heightSpacing(8),
                    MidhillTexts.text400(
                      context,
                      text: "Your reminders will appear here",
                      fontSize: 13,
                      color: const Color(0xff6C7A93),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
