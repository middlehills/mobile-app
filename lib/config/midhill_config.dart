class MidhillConfig {
  final String appTitle;
  final String apiBaseUrl;

  MidhillConfig({
    required this.appTitle,
    required this.apiBaseUrl,
  });

  /// Configuration for Development
  factory MidhillConfig.development() {
    return MidhillConfig(
      appTitle: "Mid'hill CashFlow - Dev",
      apiBaseUrl: "https://middlehill-backend.onrender.com/",
    );
  }

  /// Configuration for Staging
  factory MidhillConfig.staging() {
    return MidhillConfig(
      appTitle: "Mid'hill CashFlow - Staging",
      apiBaseUrl: "",
    );
  }

  /// Configuration for Production
  factory MidhillConfig.production() {
    return MidhillConfig(
      appTitle: "Mid'hill CashFlow",
      apiBaseUrl: "",
    );
  }
}
