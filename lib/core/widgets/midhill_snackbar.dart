// Function to show status dialog using ScaffoldMessenger
import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/widgets/midhill_texts.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

void showMidHillSnackbar(BuildContext context, String message,
    {bool isError = true, double offset = 100}) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  // Clear any currently displayed snackbar before showing a new one
  scaffoldMessenger.hideCurrentSnackBar();

  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            isError
                ? Icons.error_outline
                : Icons.check, // error or success icon
            color: isError
                ? MidhillColors.white
                : const Color.fromRGBO(67, 160, 72, 1),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: MidhillTexts.text400(
              context, text: message, // error or success message
              color: MidhillColors.white,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
      backgroundColor:
          isError ? Colors.red : const Color.fromARGB(255, 38, 85, 146),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal, // slide away
      duration: const Duration(seconds: 5), // auto-dismiss after 5 seconds
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      // top snackBar
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - offset,
        right: 20,
        left: 20,
      ),
    ),
  );
}
