import 'dart:developer';

import 'package:mono_connect/mono_connect.dart';

String generateReference() {
  final now = DateTime.now();
  return 'ref_${now.millisecondsSinceEpoch}';
}

ConnectConfiguration createConfig({
  required String name,
  required String email,
  required String identity,
}) {
  return ConnectConfiguration(
    publicKey: 'test_pk_ea8yn9kjci3u3upka1qp',
    onSuccess: (code) {
      log('Success with code: $code');
    },
    customer: MonoCustomer(
      newCustomer: MonoNewCustomer(
        name: name,
        email: email,
        identity: MonoCustomerIdentity(
          type: 'bvn',
          number: identity,
        ),
      ),
      // or
      // existingCustomer: MonoExistingCustomer(
      //   id: '6759f68cb587236111eac1d4',
      // ),
    ),
    // selectedInstitution: const ConnectInstitution(
    //   id: '5f2d08be60b92e2888287702',
    //   authMethod: ConnectAuthMethod.mobileBanking,
    // ),
    reference: generateReference(),
    onEvent: (event) {
      log(event.toString());
    },
    onClose: () {
      log('Widget closed.');
    },
  );
}
