// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mid_hill_cash_flow/theme/midhill_colors.dart';

class MidhillTheme {
  // Light theme definition
  static ThemeData lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: MidhillColors.primaryColor,
        brightness: Brightness.light,
        secondary: MidhillColors.secondaryColor,
      ),
      primaryColor: MidhillColors.primaryColor,
      scaffoldBackgroundColor: const Color(0xffF9FAFB),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: MidhillColors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: MidhillColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      useMaterial3: true,
      textTheme: GoogleFonts.openSansTextTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MidhillColors.primaryColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  // Dark theme definition - temp
  static ThemeData darkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: MidhillColors.primaryColor,
        brightness: Brightness.dark,
        secondary: MidhillColors.secondaryColor,
      ),
      scaffoldBackgroundColor: MidhillColors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: MidhillColors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: MidhillColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
        bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MidhillColors.primaryColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
