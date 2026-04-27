import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // ── Palette (from Figma: "hacker/terminal" green-on-dark) ──────────────────
  static const Color slate950 = Color(0xFF020617);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate300 = Color(0xFFCBD5E1);

  static const Color green200 = Color(0xFFBBF7D0);
  static const Color green300 = Color(0xFF86EFAC);
  static const Color green400 = Color(0xFF4ADE80);
  static const Color green500 = Color(0xFF22C55E);
  static const Color green600 = Color(0xFF16A34A);
  static const Color green700 = Color(0xFF15803D);

  static const Color emerald500 = Color(0xFF10B981);
  static const Color teal500   = Color(0xFF14B8A6);
  static const Color cyan500   = Color(0xFF06B6D4);
  static const Color blue500   = Color(0xFF3B82F6);

  static const Color red500    = Color(0xFFEF4444);
  static const Color yellow500 = Color(0xFFEAB308);

  // ── Text styles ─────────────────────────────────────────────────────────────
  static TextStyle get _mono => GoogleFonts.jetBrainsMono();

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        primaryColor: green500,
        scaffoldBackgroundColor: slate950,
        colorScheme: const ColorScheme.dark(
          primary: green500,
          secondary: green600,
          surface: slate900,
          error: red500,
        ),
        textTheme: TextTheme(
          displayLarge: _mono.copyWith(
            fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white,
          ),
          displayMedium: _mono.copyWith(
            fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white,
          ),
          displaySmall: _mono.copyWith(
            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white,
          ),
          headlineMedium: _mono.copyWith(
            fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white,
          ),
          bodyLarge: _mono.copyWith(fontSize: 16, color: slate300),
          bodyMedium: _mono.copyWith(fontSize: 14, color: slate400),
          labelSmall: _mono.copyWith(fontSize: 12, color: green400),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: green400,
            side: const BorderSide(color: green600),
            textStyle: _mono.copyWith(fontSize: 14),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: green600,
            foregroundColor: Colors.white,
            textStyle: _mono.copyWith(fontSize: 14),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      );
}
