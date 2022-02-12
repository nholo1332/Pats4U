import 'package:flutter/material.dart';

const int bluePalettePrimary = 0xFF051064;
const MaterialColor bluePalette = MaterialColor(bluePalettePrimary, <int, Color>{
  50: Color(0xFFE1E2EC),
  100: Color(0xFFB4B7D1),
  200: Color(0xFF8288B2),
  300: Color(0xFF505893),
  400: Color(0xFF2B347B),
  500: Color(bluePalettePrimary),
  600: Color(0xFF040E5C),
  700: Color(0xFF040C52),
  800: Color(0xFF030948),
  900: Color(0xFF010536),
});

const int redPalettePrimary = 0xFFAC0000;
const MaterialColor redPalette = MaterialColor(redPalettePrimary, <int, Color>{
  50: Color(0xFFF5E0E0),
  100: Color(0xFFE6B3B3),
  200: Color(0xFFD68080),
  300: Color(0xFFC54D4D),
  400: Color(0xFFB82626),
  500: Color(redPalettePrimary),
  600: Color(0xFFA50000),
  700: Color(0xFF9B0000),
  800: Color(0xFF920000),
  900: Color(0xFF820000),
});

ThemeData lightTheme() {
  return ThemeData(
    fontFamily: 'Poppins',
    primarySwatch: bluePalette,
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: bluePalette,
        onPrimary: Colors.white,
        secondary: redPalette,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black87,
        surface: Colors.white,
        onSurface: Colors.black87,
    ),
  );
}