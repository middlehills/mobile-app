import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mid_hill_cash_flow/config/midhill_config.dart';
import 'package:mid_hill_cash_flow/features/onboarding/domain/onboarding_provider.dart';
import 'package:mid_hill_cash_flow/main/midhill_app.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

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
      ],
      child: MidhillApp(config: config),
    ),
  );
}
