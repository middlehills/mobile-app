import 'dart:developer';

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
}) {
  return ConnectConfiguration(
    publicKey: 'test_pk_ea8yn9kjci3u3upka1qp',
    onSuccess: (code) async {
      log('Success with code: $code');
      await profileValue.connectMonoAccount(
        baseUrl: apiUrlProviderValue.apiUrl!,
        code: code,
      );
    },
    customer: MonoCustomer(
      newCustomer: profileValue.midhillUser!.monoId == null
          ? MonoNewCustomer(
              name: name,
              email: email,
              identity: MonoCustomerIdentity(
                type: 'bvn',
                number: identity,
              ),
            )
          : null,
      // or
      existingCustomer: profileValue.midhillUser!.monoId != null
          ? MonoExistingCustomer(
              id: profileValue.midhillUser!.monoId!,
            )
          : null,
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
