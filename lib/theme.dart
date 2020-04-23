import 'package:flutter/material.dart';

final ThemeData CompanyThemeData = new ThemeData(
  primaryColor: AppColors.primary,
  accentColor:  AppColors.accent


);

class AppColors {
  AppColors._(); // this basically makes it so you can instantiate this class
  static const Map<int, Color> blue = const <int, Color> {
      50:  const Color(0xFFe8eaf6),
      100: const Color(0xFFc5cbe9),
      200: const Color(0xFF7985cb),
      300: const Color(0xFF7985cb),
      400: const Color(0xFF5c6bc0),
      500: const Color(0xFF3f51b5),
      600: const Color(0xFF394aae),
      700: const Color(0xFF3140a5),
      800: const Color(0xFF29379d),
      900: const Color(0xFF1b278d),
  };
  
  static const Map<int, Color> green = const <int, Color> {
       50: const Color(0xFFe8eaf6),
      100: const Color(0xFFc5cbe9),
      200: const Color(0xFF7985cb),
      300: const Color(0xFF7985cb),
      400: const Color(0xFF5c6bc0),
      500: const Color(0xFF3f51b5),
      600: const Color(0xFF394aae),
      700: const Color(0xFF3140a5),
      800: const Color(0xFF29379d),
      900: const Color(0xFF1b278d),
  };
  static const Color icons = Color(0xFFFFFFFF) ;
  static const Color primary = Color(0xFF009688);
  static const Color darkprimary = Color(0xFF00796B);
  static const Color lightprimary = Color(0xFFB2DFDB);
  
  static const Color accent = Color(0xFF009688);
  static const Color textPrimery = Color(0xFF212121);
  static const Color textSecundart = Color(0xFF757575);
  static const Color dividerColor = Color(0xFFBDBDBD);
  static const Color fieldInFocus = Colors.pink;
  static const Color field = Colors.white;

}
