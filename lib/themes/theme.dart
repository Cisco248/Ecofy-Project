import 'package:e_wms_mobile/utilities/constants/color.dart';
import 'package:e_wms_mobile/themes/mods/button_theme.dart';
import 'package:flutter/material.dart';
import 'package:e_wms_mobile/utilities/constants/font.dart';
import 'package:e_wms_mobile/themes/mods/input_theme.dart';
import 'package:e_wms_mobile/themes/mods/card_theme.dart';
import 'package:e_wms_mobile/themes/mods/header_theme.dart';

class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.bgLight,
    appBarTheme: AppHeaderTheme.lightHeaderTheme,
    cardTheme: AppCardTheme.cardLightTheme,
    textTheme: AppTextStyles.textLightTheme,
    // Customizable Input Field
    inputDecorationTheme: AppInputTheme.inputAppLightTheme,
    // Customizable Button
    buttonTheme: AppButtonTheme.buttonTheme,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bgDark,
    appBarTheme: AppHeaderTheme.darkHeaderTheme,
    cardTheme: AppCardTheme.cardDarkTheme,
    textTheme: AppTextStyles.textDarkTheme,
    inputDecorationTheme: AppInputTheme.inputAppDarkTheme,
    buttonTheme: AppButtonTheme.buttonTheme,
  );
}
