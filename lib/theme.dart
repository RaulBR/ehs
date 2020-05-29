import 'package:flutter/material.dart';

final ThemeData companyThemeData = new ThemeData(
  primaryColor: AppColors.primary,
  accentColor: AppColors.accent,
  cardColor: AppColors.icons,
  buttonColor: AppColors.primary,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.primary,
    selectedItemColor: Colors.red,
      
    
  ),
  // buttonBarTheme: ButtonBarThemeData(
  //   buttonAlignedDropdown: companyThemeData
  // ),
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.primary,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: AppColors.icons,
    backgroundColor: AppColors.primary,
  ),
  iconTheme: IconThemeData(color: AppColors.icons),
  colorScheme: ColorScheme.light(primary: AppColors.primary),
);

class AppColors {
  AppColors._(); // this basically makes it so you can instantiate this class
  static const Map<int, Color> green = const <int, Color>{
    50: const Color(0xFFe0efed),
    100: const Color(0xFFb3d7d3),
    200: const Color(0xFF80bcb5),
    300: const Color(0xFF4da197),
    400: const Color(0xFF268d81),
    500: const Color(0xFF00796b),
    600: const Color(0xFF007163),
    700: const Color(0xFF006658),
    800: const Color(0xFF005c4e),
    900: const Color(0xFF00493c),
  };




  static const Map<int, Color> tfPiker = const <int, Color>{
    0: const Color(0xFFFFEC19),
    1: const Color(0xF7FFC100),
    2: const Color(0xFFFF9800),
    3: const Color(0xFFFF5607),
    4: const Color(0xFFF6412D),
    5: const Color(0xFFFF0000),
  };


  static const Map<int, Color> greqween = const <int, Color>{
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
  static const Color icons = Color(0xFFFFFFFF);
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
