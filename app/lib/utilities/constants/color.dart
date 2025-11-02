import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Primary
  static const Color primary = Color(0xFF19BC6A);
  static const Color primaryLight = Color(0xFF6FFFB0);
  static const Color primaryDark = Color(0xFF007B43);

  // Secondary
  // static const Color secondary = Color(0xFF00BCD4);
  // static const Color secondaryLight = Color(0xFF62EFFF);
  // static const Color secondaryDark = Color(0xFF008BA3);

  // Background
  static const Color bgLight = Color(0xFFFFFFFF);
  static const Color bgDark = Color(0xFF121212);

  // Appbar
  static const Color appBgLight = Color(0xFFEFEFEF);
  // static const Color appBgDark = Color(value);

  // Text
  static const Color txtLight = Color(0xFF212121);
  static const Color txtDark = Color(0xFFFFFFFF);
  static const Color txtWhite = Color(0xFFFFFFFF);
  static const Color txtBlack = Color(0x00000000);

  // Status / System
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // State
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color focus = primary;
  static const Color divider = Color(0xFFBDBDBD);

  // Borders
  static const Color borderLight = Color(0xFF777777);
  static const Color borderLightFocus = primary;
  static const Color borderLightError = error;

  static const Color borderDark = Color(0xDFFFFFFF);
  static const Color borderDarkFocus = primary;
  static const Color borderDarkError = Color.fromRGBO(244, 67, 54, 1);

  // Shadows
  static const Color shadowLight = Color.fromARGB(100, 0, 0, 0);
  static const Color shadowDark = Color.fromARGB(100, 255, 255, 255);

  // Headers
  static const Color headerLight = Color(0xFF212121);
  static const Color headerDark = Color(0xFF757575);

  // Cards
  static const Color cardLight = Color(0xFFEBEBEB);
  static const Color cardDark = Color(0xFF1B1B1B);

  // SnackBars
  static const Color snackBarSuccess = Color(0xffE2FFF0);
  static const Color snackBarError = Color(0xffFFC4C4);

  // Others
  static const Color gray = Color(0x95FFFFFF);
  static const Color lightGray = Color(0xFFE0E0E0);
  static const Color darkGray = Color(0xFF757575);
}
