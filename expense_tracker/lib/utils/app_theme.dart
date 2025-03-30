import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color errorColor = Color(0xFFB00020);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF1D1D1D);
  static const Color secondaryTextColor = Color(0xFF757575);

  // Dark theme colors
  static const Color darkPrimaryColor = Color(0xFFBB86FC);
  static const Color darkSecondaryColor = Color(0xFF03DAC6);
  static const Color darkErrorColor = Color(0xFFCF6679);
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkCardColor = Color(0xFF1E1E1E);
  static const Color darkTextColor = Color(0xFFF5F5F5);
  static const Color darkSecondaryTextColor = Color(0xFFBDBDBD);

  // Category colors
  static const List<Color> categoryColors = [
    Color(0xFF6200EE), // Purple
    Color(0xFF03DAC6), // Teal
    Color(0xFFFF5722), // Deep Orange
    Color(0xFF4CAF50), // Green
    Color(0xFF2196F3), // Blue
    Color(0xFFFFC107), // Amber
    Color(0xFFE91E63), // Pink
    Color(0xFF607D8B), // Blue Grey
  ];

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
        surfaceContainerHighest: backgroundColor,
        surface: cardColor,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurfaceVariant: textColor,
        onSurface: textColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.light().textTheme,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: darkPrimaryColor,
        secondary: darkSecondaryColor,
        error: darkErrorColor,
        surfaceDim: darkBackgroundColor,
        surface: darkCardColor,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurfaceVariant: darkTextColor,
        onSurface: darkTextColor,
      ),
      scaffoldBackgroundColor: darkBackgroundColor,
      cardTheme: CardTheme(
        color: darkCardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.dark().textTheme,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkCardColor,
        foregroundColor: darkTextColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkTextColor,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: darkPrimaryColor,
        foregroundColor: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimaryColor,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade800),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkPrimaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}

