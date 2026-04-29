import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Base green palette
  static const Color deepForestGreen = Color(0xFF0A1F14);
  static const Color darkSurface = Color(0xFF0F2D1F);
  static const Color darkSurfaceVariant = Color(0xFF163527);
  static const Color primaryGreen = Color(0xFF1B4332);
  static const Color mediumGreen = Color(0xFF2D6A4F);
  static const Color accentGreen = Color(0xFF52B788);
  static const Color creamCard = Color(0xFFF5F0E8);
  static const Color creamCardDark = Color(0xFFEDE8DC);
  static const Color mutedGreen = Color(0xFFA8C5B5);
  static const Color goldAccent = Color(0xFFD4A017);
  static const Color onDarkText = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF52B788);
  static const Color warning = Color(0xFFD4A017);
  static const Color error = Color(0xFFC0392B);

  // Accent color options
  static const Color accentBlue = Color(0xFF1A5276);
  static const Color accentPurple = Color(0xFF4A235A);
  static const Color accentRed = Color(0xFF7B241C);
  static const Color accentBrown = Color(0xFF4A2C17);

  static ThemeData buildTheme(Color accentColor) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: accentColor,
        primaryContainer: accentColor.withAlpha(77),
        secondary: accentGreen,
        secondaryContainer: accentGreen.withAlpha(51),
        surface: darkSurface,
        surfaceContainerHighest: darkSurfaceVariant,
        error: error,
        onPrimary: onDarkText,
        onSecondary: onDarkText,
        onSurface: onDarkText,
        outline: mutedGreen.withAlpha(102),
        outlineVariant: mutedGreen.withAlpha(51),
      ),
      scaffoldBackgroundColor: deepForestGreen,
      textTheme: GoogleFonts.outfitTextTheme(
        TextTheme(
          displayLarge: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: onDarkText,
          ),
          displayMedium: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: onDarkText,
          ),
          headlineLarge: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: onDarkText,
          ),
          headlineMedium: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: onDarkText,
          ),
          titleLarge: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: onDarkText,
          ),
          titleMedium: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: onDarkText,
          ),
          titleSmall: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: onDarkText,
          ),
          bodyLarge: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: onDarkText,
          ),
          bodyMedium: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: onDarkText,
          ),
          bodySmall: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: mutedGreen,
          ),
          labelLarge: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: onDarkText,
          ),
          labelMedium: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: onDarkText,
          ),
          labelSmall: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: mutedGreen,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: darkSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: mutedGreen.withAlpha(77)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: mutedGreen.withAlpha(77)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: accentColor, width: 1.5),
        ),
        labelStyle: const TextStyle(color: mutedGreen),
        hintStyle: const TextStyle(color: mutedGreen),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: onDarkText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Outfit',
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: onDarkText),
      dividerTheme: DividerThemeData(
        color: mutedGreen.withAlpha(51),
        thickness: 1,
      ),
    );
  }

  static ThemeData get lightTheme => buildTheme(accentGreen);
  static ThemeData get darkTheme => buildTheme(accentGreen);
}
