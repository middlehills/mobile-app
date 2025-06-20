import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/core/widgets/error_dialog_content_widget.dart';
import 'package:mid_hill_cash_flow/core/widgets/success_dialog_content.dart';
import 'package:mid_hill_cash_flow/features/profile/domain/profile_provider.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';
import 'package:mono_connect/mono_connect.dart';

String generateReference() {
  final now = DateTime.now();
  return 'ref_${now.millisecondsSinceEpoch}';
}

ConnectConfiguration createConfig({
  required String name,
  required String email,
  required String identity,
  required ProfileProvider profileValue,
  required ApiUrlProvider apiUrlProviderValue,
  required BuildContext context,
}) {
  return ConnectConfiguration(
    publicKey: 'test_pk_ea8yn9kjci3u3upka1qp',
    onSuccess: (code) async {
      log('Success with code: $code');
      await profileValue.connectMonoAccount(
        baseUrl: apiUrlProviderValue.apiUrl!,
        code: code,
      );
      profileValue.fetchUser(
        baseUrl: apiUrlProviderValue.apiUrl!,
      );
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: profileValue.connectMonoApiResponse?.statusCode == 200
                  ? SuccessDialogContent(
                      successHeader: "Account Connect",
                      successMessage:
                          profileValue.connectMonoApiResponse!.message ??
                              "Account connected successfully")
                  : ErrorDialogContent(
                      errorHeader:
                          profileValue.connectMonoApiResponse!.message ??
                              "Account Error!",
                      errror: profileValue.connectMonoApiResponse?.message ??
                          "Error while connecting account.",
                    ),
            );
          },
        );
      }
    },
    customer: MonoCustomer(
        // newCustomer: profileValue.midhillUser!.monoId == null
        newCustomer: MonoNewCustomer(
      name: name,
      email: email,
      identity: MonoCustomerIdentity(
        type: 'bvn',
        number: identity,
      ),
    )
        // : null,
        // or
        // existingCustomer: profileValue.midhillUser!.monoId != null
        //     ? MonoExistingCustomer(
        //         id: profileValue.midhillUser!.monoId!,
        //       )
        //     : null,
        ),
    reference: generateReference(),
    onEvent: (event) {
      log(event.toString());
    },
    onClose: () {
      log('Widget closed.');
    },
  );
}
