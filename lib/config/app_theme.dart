import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colores vibrantes y amigables para niños
  static const Color mathColor = Color(0xFF5C6BC0); // Azul índigo suave
  static const Color languageColor = Color(0xFF66BB6A); // Verde menta
  static const Color divisionColor = Color(0xFFEC407A); // Rosa vibrante
  static const Color fractionColor = Color(0xFFAB47BC); // Púrpura
  static const Color spellingColor = Color(0xFF42A5F5); // Azul cielo
  static const Color grammarColor = Color(0xFFFF7043); // Naranja coral
  
  static const Color rewardColor = Color(0xFFFFCA28); // Amarillo dorado
  static const Color successColor = Color(0xFF66BB6A); // Verde éxito
  static const Color dangerColor = Color(0xFFEF5350); // Rojo suave
  static const Color backgroundColor = Color(0xFFFFFBF5); // Crema cálido
  static const Color cardBackground = Color(0xFFFFFFFF); // Blanco puro

  // Primary colors
  static const Color primaryColor = Color(0xFF5C6BC0);
  static const Color secondaryColor = Color(0xFF66BB6A);
  static const Color accentColor = Color(0xFFFFCA28);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        background: backgroundColor,
        surface: cardBackground,
      ),
      textTheme: GoogleFonts.comicNeueTextTheme().copyWith(
        headlineLarge: GoogleFonts.comicNeue(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2C3E50),
          letterSpacing: 0.5,
        ),
        headlineMedium: GoogleFonts.comicNeue(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2C3E50),
        ),
        headlineSmall: GoogleFonts.comicNeue(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF34495E),
        ),
        titleLarge: GoogleFonts.comicNeue(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2C3E50),
        ),
        titleMedium: GoogleFonts.comicNeue(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF34495E),
        ),
        bodyLarge: GoogleFonts.comicNeue(
          fontSize: 17,
          color: const Color(0xFF34495E),
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.comicNeue(
          fontSize: 15,
          color: const Color(0xFF5A6C7D),
          height: 1.4,
        ),
        labelLarge: GoogleFonts.comicNeue(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          shadowColor: Colors.black26,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 6,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: cardBackground,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryColor, width: 2.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Color(0xFF2C3E50)),
      ),
    );
  }

  static ThemeData get childTheme {
    return lightTheme.copyWith(
      scaffoldBackgroundColor: const Color(0xFFFFF9F0),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        background: const Color(0xFFFFF9F0),
        surface: cardBackground,
      ),
      textTheme: GoogleFonts.comicNeueTextTheme().copyWith(
        headlineLarge: GoogleFonts.comicNeue(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2C3E50),
          letterSpacing: 0.5,
        ),
        headlineMedium: GoogleFonts.comicNeue(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2C3E50),
        ),
        headlineSmall: GoogleFonts.comicNeue(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF34495E),
        ),
        bodyLarge: GoogleFonts.comicNeue(
          fontSize: 19,
          color: const Color(0xFF34495E),
          height: 1.6,
        ),
      ),
    );
  }
}
