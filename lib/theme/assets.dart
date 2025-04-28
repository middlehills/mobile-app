// lib/core/theme/assets.dart

class MidhillAssets {
  MidhillAssets._();

  // Icons

  static String customIcon({required String iconName}) =>
      'assets/icons/${iconName}_icon.svg'; // e.g "assets/icons/home_icon.svg" where home is the iconName.

  static String customImage({required String iconName}) =>
      'assets/images/${iconName}_image.png';
}
