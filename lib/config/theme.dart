
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// definimos la paleta de colores principal basada en la referencia
class AppColors {
  static const Color background = Color(0xFF0D0D0D); // fondo principal oscuro
  static const Color surface = Color(0xFF1A1A1A); // color para tarjetas y superficies
  static const Color primary = Color(0xFF00F57A); // acento principal verde neon
  static const Color secondary = Color(0xFF944BFF); // acento secundario purpura
  static const Color accentBlue = Color(0xFF0075FF); // acento adicional azul

  static const Color textPrimary = Color(0xFFFFFFFF); // color de texto principal blanco
  static const Color textSecondary = Color(0xFFA3A3A3); // color de texto secundario gris
  static const Color border = Color(0xFF262626); // color para bordes sutiles
}

// este es el tema principal de la aplicacion
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: AppColors.primary,
  
  // configuracion de la tipografia con google fonts
  textTheme: GoogleFonts.interTextTheme(
    ThemeData.dark().textTheme,
  ).copyWith(
    bodyLarge: GoogleFonts.inter(color: AppColors.textPrimary),
    bodyMedium: GoogleFonts.inter(color: AppColors.textSecondary),
    titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
    titleMedium: GoogleFonts.inter(fontWeight: FontWeight.w500, color: AppColors.textPrimary),
    labelLarge: GoogleFonts.inter(fontWeight: FontWeight.w600, color: AppColors.background),
  ),

  // estilo para los appbar
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.textPrimary),
  ),

  // estilo para los botones elevados
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.background, // color del texto y los iconos del boton
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // forma de pildora
      ),
    ),
  ),

  // estilo para las tarjetas
  cardTheme: CardThemeData( // cambiado de CardTheme a CardThemeData
    color: AppColors.surface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: AppColors.border, width: 1),
    ),
  ),

  // estilo para los campos de texto
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.border, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.border, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    hintStyle: GoogleFonts.inter(color: AppColors.textSecondary),
    labelStyle: GoogleFonts.inter(color: AppColors.textSecondary),
  ),

  // estilo para los iconos
  iconTheme: const IconThemeData(
    color: AppColors.textSecondary,
  ),

  // color de acentuacion para elementos como checkboxes o sliders
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.surface,
    // background y onBackground estan deprecados, usamos surface y onSurface
    onPrimary: AppColors.background,
    onSecondary: AppColors.textPrimary,
    onSurface: AppColors.textPrimary,
  ),
);
