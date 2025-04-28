import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/config/midhill_config.dart';
import 'package:mid_hill_cash_flow/routes/midhill_router.dart';
import 'package:mid_hill_cash_flow/theme/midhill_theme.dart';
import 'package:mid_hill_cash_flow/utils/api_url_provider.dart';
import 'package:provider/provider.dart';

class MidhillApp extends StatefulWidget {
  final MidhillConfig config;

  const MidhillApp({super.key, required this.config});

  @override
  State<MidhillApp> createState() => _MidhillAppState();
}

class _MidhillAppState extends State<MidhillApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<ApiUrlProvider>(context, listen: false)
        .setBaseUrl(widget.config);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: widget.config.appTitle,
      debugShowCheckedModeBanner: false,
      routerConfig: MidhillRouter.returnRouter,
      theme: MidhillTheme.lightTheme(),
      darkTheme: MidhillTheme.darkTheme(),
      themeMode: ThemeMode.light,
    );
  }
}
