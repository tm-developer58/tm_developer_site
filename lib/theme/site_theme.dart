import 'package:flutter/material.dart';

abstract final class SiteColors {
  static const navy = Color(0xFF0F172A);
  static const navySoft = Color(0xFF1E293B);
  static const blue = Color(0xFF2563EB);
  static const blueDark = Color(0xFF1D4ED8);
  static const blueSoft = Color(0xFFEFF6FF);
  static const canvas = Color(0xFFF8FAFC);
  static const surface = Colors.white;
  static const surfaceMuted = Color(0xFFF1F5F9);
  static const text = Color(0xFF0F172A);
  static const textMuted = Color(0xFF475569);
  static const border = Color(0xFFE2E8F0);
  static const success = Color(0xFF15803D);
}

abstract final class SiteSpacing {
  static const double page = 24;
  static const double section = 80;
  static const double radius = 16;
  static const double contentWidth = 1180;
}

ThemeData buildSiteTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: SiteColors.blue,
    brightness: Brightness.light,
    surface: SiteColors.surface,
  );

  final base = ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: SiteColors.canvas,
    textTheme: Typography.blackCupertino.apply(
      bodyColor: SiteColors.text,
      displayColor: SiteColors.text,
    ),
    useMaterial3: true,
  );

  return base.copyWith(
    focusColor: SiteColors.blue.withValues(alpha: 0.16),
    splashColor: SiteColors.blue.withValues(alpha: 0.08),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: SiteColors.blue,
        foregroundColor: Colors.white,
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: SiteColors.navy,
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        side: const BorderSide(color: SiteColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: SiteColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: SiteColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: SiteColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: SiteColors.blue, width: 2),
      ),
    ),
  );
}
