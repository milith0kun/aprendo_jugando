import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Paleta minimalista y elegante con colores claros
  static const Color mathColor = Color(0xFF7AA5E8); // Azul pastel sereno
  static const Color languageColor = Color(0xFF81C995); // Verde menta suave
  static const Color divisionColor = Color(0xFFE89BB5); // Rosa pastel
  static const Color fractionColor = Color(0xFFB49CDC); // Lavanda suave
  static const Color spellingColor = Color(0xFF81CDE6); // Azul cielo claro
  static const Color grammarColor = Color(0xFFFFAA8A); // Melocotón suave

  static const Color rewardColor = Color(0xFFFFD97D); // Dorado pastel
  static const Color successColor = Color(0xFF81C995); // Verde menta suave
  static const Color dangerColor = Color(0xFFFF8E8E); // Coral suave
  static const Color backgroundColor = Color(0xFFFAFAFA); // Gris muy claro
  static const Color cardBackground = Color(0xFFFFFFFF); // Blanco puro
  static const Color surfaceColor = Color(0xFFF5F7FA); // Gris azulado claro
  static const Color borderColor = Color(0xFFE8ECF1); // Borde sutil

  // Primary colors - Minimalista
  static const Color primaryColor = Color(0xFF6B8DD6); // Azul suave
  static const Color secondaryColor = Color(0xFF81C995); // Verde menta
  static const Color accentColor = Color(0xFFFFAA8A); // Melocotón
  static const Color textPrimary = Color(0xFF1A1F36); // Azul oscuro profundo
  static const Color textSecondary = Color(0xFF6B7280); // Gris medio
  static const Color textTertiary = Color(0xFF9CA3AF); // Gris claro

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
      // Tipografía moderna y limpia con Poppins
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        headlineLarge: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: -0.3,
          height: 1.3,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: -0.2,
          height: 1.4,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0,
          height: 1.4,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
          letterSpacing: 0.1,
          height: 1.5,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.6,
          letterSpacing: 0.2,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.5,
          letterSpacing: 0.2,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textTertiary,
          height: 1.4,
          letterSpacing: 0.2,
        ),
        labelLarge: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
        labelMedium: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
        ),
      ),
      // Botones minimalistas
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ).copyWith(
          elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return 0;
              if (states.contains(MaterialState.hovered)) return 1;
              return 0;
            },
          ),
        ),
      ),
      // Cards minimalistas con bordes sutiles
      cardTheme: CardThemeData(
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: borderColor,
            width: 1.5,
          ),
        ),
        color: cardBackground,
        margin: const EdgeInsets.all(0),
      ),
      // Inputs limpios y elegantes
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: dangerColor, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      // AppBar limpio
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: backgroundColor,
        foregroundColor: textPrimary,
        iconTheme: const IconThemeData(color: textPrimary),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      // Divisor sutil
      dividerTheme: const DividerThemeData(
        color: borderColor,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData get childTheme {
    return lightTheme.copyWith(
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        background: backgroundColor,
        surface: cardBackground,
      ),
      // Tipografía ligeramente más grande para niños, pero manteniendo el estilo limpio
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        headlineLarge: GoogleFonts.poppins(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.5,
          height: 1.2,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: -0.3,
          height: 1.3,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: -0.2,
          height: 1.4,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0,
          height: 1.4,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.6,
          letterSpacing: 0.2,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.5,
          letterSpacing: 0.2,
        ),
        labelLarge: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
