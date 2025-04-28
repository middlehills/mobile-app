import 'package:flutter/material.dart';
import 'package:mid_hill_cash_flow/config/midhill_config.dart';

class ApiUrlProvider extends ChangeNotifier {
  // apiUrl
  String? apiUrl;

  void setBaseUrl(MidhillConfig appConfig) {
    apiUrl = appConfig.apiBaseUrl;
  }
}
