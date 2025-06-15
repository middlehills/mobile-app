import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:mid_hill_cash_flow/config/midhill_config.dart';
import 'package:mid_hill_cash_flow/features/authentication/domain/auth_provider.dart';
import 'package:mid_hill_cash_flow/features/home/domain/upload_provider.dart';
import 'package:mid_hill_cash_flow/features/nav_bar/nav_bar_provider.dart';
import 'package:mid_hill_cash_flow/features/onboarding/domain/onboarding_provider.dart';
import 'package:mid_hill_cash_flow/features/profile/domain/profile_provider.dart';
import 'package:mid_hill_cash_flow/features/records/domain/records_provider.dart';
import 'package:mid_hill_cash_flow/main/midhill_app.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // await Intercom.instance.initialize('xk5ak5wz',
  //     iosApiKey:
  //         'ios_sdk-82cc4eb1073418f10e062adc9155047ac5343485', // from Intercom dashboard
  //     androidApiKey:
  //         'android_sdk-5a31e1f5f820711c9632969f5798bd9847a4dd94' // from Intercom dashboard
  //     );

  // Read the environment variable passed via --dart-define.
  const String env = String.fromEnvironment('ENV', defaultValue: 'dev');

  // Select the correct configuration based on the ENV value.
  late final MidhillConfig config;
  switch (env) {
    case 'dev':
      config = MidhillConfig.development();
      break;
    case 'staging':
      config = MidhillConfig.staging();
      break;
    case 'prod':
      config = MidhillConfig.production();
      break;
    default:
      config = MidhillConfig.development();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ApiUrlProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OnboardingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UploadProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RecordsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
      ],
      child: MidhillApp(config: config),
    ),
  );
}
